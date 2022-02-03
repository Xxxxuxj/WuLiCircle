//
//  CommodityView.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "CommodityView.h"

@interface CommodityView()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //判断输入的是否为删除
    BOOL    isDelete;
    
    //判断输入的场景是否为回复
    BOOL    isReply;
    
    //判断加载完图片后是否已经reloadData
    __block BOOL picArrayReloadData;
    
    __block BOOL commentArrayReloadData;
    
    //cell的高度参数
    CGFloat imgViewHeight;
    
    //存放 评论的id的数组
    __block NSMutableArray *commentArray;
    
    //存放的为 评论的BmobObject对象
    NSMutableArray *bmobObjectCommentArray;
    
    //存放的为 评论cell中每一个row的height
    NSMutableArray *rowHeightArray;
    
    //存放的为 回复的cell的indexPath
    NSIndexPath *replyIndexPath;
    
    CGFloat informationSectionHeight;
    
    BOOL showMore;
    
    CGFloat Width;
    CGFloat Height;
    
    BmobObject *currentCommodity;
    
    NSIndexPath *selectedIndexPath;
}
@end




@implementation CommodityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"resetCommentViewFrame" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"replyTextViewReply" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getRowHeightArray" object:nil];
}


- (instancetype)initWithFrame:(CGRect)frame model:(CommodityModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        //model传入
        self.model=model;
        commentArray=[[NSMutableArray alloc]init];
        picArrayReloadData=NO;
        commentArrayReloadData=NO;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetCommentViewFrame:) name:@"resetCommentViewFrame" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(replyTextViewReply:) name:@"replyTextViewReply" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRowHeightArray:) name:@"getRowHeightArray" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showMore:) name:@"showMore" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeShowMore:) name:@"closeShowMore" object:nil];
        Width=self.frame.size.width;
        Height=self.frame.size.height;
        //初始化
        self.picArray=[[NSMutableArray alloc]init];
        bmobObjectCommentArray=[[NSMutableArray alloc]init];
        picArrayReloadData=NO;
        commentArray=[NSMutableArray arrayWithArray: _model.commentArray];
        
        BmobQuery *bquery=[BmobQuery queryWithClassName:@"Commodity"];
        [bquery whereKey:@"objectId" equalTo:[self.model valueForKey:@"commodityId"] ];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(array){
                self->currentCommodity=array[0];
                self->commentArray=[self->currentCommodity objectForKey:@"commentArray"];
                for(NSString* commentID in self->commentArray){
                    BmobQuery *bquery=[BmobQuery queryWithClassName:@"CommodityComment"];
                    [bquery whereKey:@"objectId" equalTo:commentID];
                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array.count>=1){
                            
                            BmobObject *comment=array[0];
                            //将comment存入bmobObjectCommentArray
                            [self->bmobObjectCommentArray addObject:comment];
                            
                            if(self->bmobObjectCommentArray.count == self->commentArray.count){
                                self->rowHeightArray=[[NSMutableArray alloc]init];
                                for(int i=0;i<self->bmobObjectCommentArray.count;i++){
                                    CGFloat height=80;
                                    NSArray * replyArray=[self->bmobObjectCommentArray[i] objectForKey:@"replyArray"];
                                    if(replyArray.count <=0){
                                        height=height;
                                        
                                    }else if(replyArray.count <=3){
                                        height+=20*(replyArray.count+1);
                                    }else{
                                        height+=100;
                                    }
                                    [self->rowHeightArray addObject:[NSString stringWithFormat:@"%lf",height+10] ];
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self setUI];
                                });
                            }
                            
                        }
                    }];
                }
            }
        }];
        
        
        
        //根据id循化拉取每一个comment数据
//        for(NSString* commentID in commentArray){
//            BmobQuery *bquery=[BmobQuery queryWithClassName:@"CommodityComment"];
//            [bquery whereKey:@"objectId" equalTo:commentID];
//            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                if(array.count>=1){
//
//                    BmobObject *comment=array[0];
//                    //将comment存入bmobObjectCommentArray
//                    [self->bmobObjectCommentArray addObject:comment];
//
//                    if(self->bmobObjectCommentArray.count == self->commentArray.count){
//                        self->rowHeightArray=[[NSMutableArray alloc]init];
//                        for(int i=0;i<self->bmobObjectCommentArray.count;i++){
//                            CGFloat height=80;
//                            NSArray * replyArray=[self->bmobObjectCommentArray[i] objectForKey:@"replyArray"];
//                            if(replyArray.count <=0){
//                                height=height;
//
//                            }else if(replyArray.count <=3){
//                                height+=20*(replyArray.count+1);
//                            }else{
//                                height+=100;
//                            }
//                            [self->rowHeightArray addObject:[NSString stringWithFormat:@"%lf",height+10] ];
//                        }
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self setUI];
//                        });
//                    }
//
//                }
//            }];
//        }
        informationSectionHeight=80;
        dispatch_queue_t queue=dispatch_queue_create("getImgViewHeight", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            for(int i=0;i<self.model.picArray.count;i++){
                NSURL *url=[NSURL URLWithString:self.model.picArray[i]];
                UIImage* img=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                [self.picArray addObject:img];
                dispatch_async(dispatch_get_main_queue(), ^{
                    CGFloat temp=(self.frame.size.width/img.size.width)*img.size.height;
                    if(self->imgViewHeight < temp ){
                        if(temp>([UIScreen mainScreen].bounds.size.height*7)/10){
                            self->imgViewHeight=([UIScreen mainScreen].bounds.size.height*7)/10;
                        }else{
                            self->imgViewHeight=temp;
                        }
                        
                    }
                    if(i==self.model.picArray.count-1){
                        //NSIndexSet *index=[NSIndexSet indexSetWithIndex:0];
                        //NSRange range = NSMakeRange(0, 1);
                        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:0];

                        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationTop];
//                        NSLog(@"%@",sectionToReload);
                        //[self.tableView reloadData];
                    }
                });
                
            }
        });
    }
    return self;
}

-(void)setUI{
    /*
     #import "ImageScrollTableViewCell.h"
     #import "CommodityInformationTableViewCell.h"
     #import "UserInformationTableViewCell.h"
     #import "CommentTableViewCell.h"
     */
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height-70) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.tableView registerClass:[ImageScrollTableViewCell class]          forCellReuseIdentifier:@"imagecell"];
    [self.tableView registerClass:[CommodityInformationTableViewCell class] forCellReuseIdentifier:@"informationcell"];
    [self.tableView registerClass:[ReleasedUserTableViewCell class]      forCellReuseIdentifier:@"usercell"];
    [self.tableView registerClass:[CommentTableViewCell class]              forCellReuseIdentifier:@"commentcell"];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:200/256.0 green:200/256.0 blue:200/256.0 alpha:1];
    
    
    
    [self addSubview:self.tableView];
    
    
    
    self.commentView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-70, self.bounds.size.width, 70)];
    self.commentView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.commentView];
    
    self.commentTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-70, 30)];
    self.commentTextView.backgroundColor=[UIColor lightGrayColor];
    [self.commentTextView.layer setCornerRadius:10.0];
    self.commentTextView.delegate=self;
    self.commentTextView.font=[UIFont systemFontOfSize:15];
    [self.commentView addSubview:self.commentTextView];
    
    
    self.commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-50, 10, 40, 30)];
    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self.commentBtn.layer setCornerRadius:10.0];
    [self.commentBtn setBackgroundColor:[UIColor blueColor]];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(submitComment) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView addSubview:self.commentBtn];
    
    self.wantBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-70, self.frame.size.height-140, 60, 60)];
    self.wantBtn.backgroundColor=[UIColor blueColor];
    [self.wantBtn setTitle:@"我想要" forState:UIControlStateNormal];
    [self.wantBtn.layer setCornerRadius:30];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(movingBtn:)];
    [self.wantBtn addGestureRecognizer:pan];
    [self addSubview:self.wantBtn];
}


- (void)textViewDidChangeSelection:(UITextView *)textView{
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    textView.scrollEnabled=NO;
    //利用sizeThatFits方法得到newSize
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    
    //控制size不要高于一个值  对newSize进行判断
    if(newSize.height<=100){
        CGRect newFrame = textView.frame;
        
        //判断是否是因为删除而改变size
        if(isDelete){
            //若是删除改变的size size的height应该为 初始的height 和 newSize的height 中较小的
            newFrame.size = CGSizeMake(fmax(width, newSize.width), fmin(height, newSize.height));
        }else{
            //若不是删除改变的size size的height应该为 初始的height 和 newSize的height 中较大的
            newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
        }
        //根据newFrame重新设置
        textView.frame= CGRectMake(newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);
        
        
        //计算承载textView 的 commentView新frame
        CGRect commentFrame=self.commentView.frame;
        //Y的新值
        CGFloat newCommentViewY=commentFrame.origin.y-(newSize.height-height);
        
        //重新设置frame
        [self.commentView setFrame:CGRectMake(0,newCommentViewY, self.bounds.size.width, newFrame.size.height+20)];
        [self.commentBtn setFrame:CGRectMake(self.bounds.size.width-50, self.commentView.frame.size.height-40, 40, 30)];
        
        
        //必须要设置 当没达到最大高度时不允许滑动
        textView.scrollEnabled=YES;
    }else{
        //必须要设置 当达到最大高度时允许滑动
        textView.scrollEnabled=YES;
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    textView.scrollEnabled=NO;
    //利用sizeThatFits方法得到newSize
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    
    //控制size不要高于一个值  对newSize进行判断
    if(newSize.height<=100){
        CGRect newFrame = textView.frame;
        
        //判断是否是因为删除而改变size
        if(isDelete){
            //若是删除改变的size size的height应该为 初始的height 和 newSize的height 中较小的
            newFrame.size = CGSizeMake(fmax(width, newSize.width), fmin(height, newSize.height));
        }else{
            //若不是删除改变的size size的height应该为 初始的height 和 newSize的height 中较大的
            newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
        }
        //根据newFrame重新设置
        textView.frame= CGRectMake(newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);
        
        
        //计算承载textView 的 commentView新frame
        CGRect commentFrame=self.commentView.frame;
        //Y的新值
        CGFloat newCommentViewY=commentFrame.origin.y-(newSize.height-height);
        
        //重新设置frame
        [self.commentView setFrame:CGRectMake(0,newCommentViewY, self.bounds.size.width, newFrame.size.height+20)];
        [self.commentBtn setFrame:CGRectMake(self.bounds.size.width-50, self.commentView.frame.size.height-40, 40, 30)];
        
        
        //必须要设置 当没达到最大高度时不允许滑动
        textView.scrollEnabled=NO;
    }else{
        //必须要设置 当达到最大高度时允许滑动
        textView.scrollEnabled=YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        isDelete=YES;
    }else{
        isDelete=NO;
    }
    return YES;

}



-(void)movingBtn:(UIPanGestureRecognizer *)recognizer{
    //得到拖拽的UIButton
    UIButton *button = (UIButton *)recognizer.view;
    //得到拖拽的偏移量
    CGPoint translation = [recognizer translationInView:button];
    
    //对拖拽事件的状态进行判断 也就是选择自定义手势的原因
    if(recognizer.state == UIGestureRecognizerStateBegan){
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        //实时设置button的center、recognizer
        button.center = CGPointMake(button.center.x + translation.x, button.center.y + translation.y);
        [recognizer setTranslation:CGPointZero inView:button];

        //对button的位置进行判断，超出范围则强行使拖拽事件结束
        //这个范围可以自己自定义
        if(button.center.x <= 40 || button.center.x>=Width-40 || button.center.y <=100 || button.center.y >=Height-100){
            [recognizer setState:UIGestureRecognizerStateEnded];
        }
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        //得到结束时button的center
        //根据center 判断应该的X和Y
        CGFloat newX=button.center.x;
        if(button.center.x <=Width/2) newX=40;
        else if(button.center.x >=Width/2) newX=Width-40;
        
        CGFloat newY=button.center.y;
        if(button.center.y <=100) newY=100;
        else if(button.center.y >=Height-100) newY=Height-100;
        
        button.center = CGPointMake(newX, newY);
        [recognizer setTranslation:CGPointZero inView:button];
    }
}



-(void)submitComment{
    
    //如果是评论
    if(!isReply){
        [self.commentTextView resignFirstResponder];
        [self setBackCommentViewFrame];
        BmobObject *comment=[BmobObject objectWithClassName:@"CommodityComment"];
        [comment setObject:self.model.commodityId forKey:@"commodityID"];
        [comment setObject:[UserDefaults getUser].userId forKey:@"userID"];
        [comment setObject:self.commentTextView.text forKey:@"content"];
        [comment setObject:[UserDefaults getUser].userName forKey:@"username"];
        //[comment setObject:[UserDefaults getUser].headImageUrl forKey:@"headImageUrl"];
        [comment setObject:[UserDefaults getUser].headImageUrlCompression forKey:@"headImageUrl-C"];
        
        NSLog(@"%@",[UserDefaults getUser]);
        [comment saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                BmobQuery *bquery=[BmobQuery queryWithClassName:@"Commodity"];
                [bquery whereKey:@"objectId" equalTo:[self.model valueForKey:@"commodityId"] ];
                [self->currentCommodity addObjectsFromArray:@[ [comment objectId]] forKey:@"commentArray"];
                [self->currentCommodity updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            if(isSuccessful){
                                [self->bmobObjectCommentArray addObject:comment];
                                [self->rowHeightArray addObject:@"80"];
                                NSLog(@"%@",[comment valueForKey:@"objectId"]);
                                [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
                                [self->commentArray addObject:[comment objectId] ];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.tableView beginUpdates];
                                    NSIndexPath *index=[NSIndexPath indexPathForRow:self->bmobObjectCommentArray.count-1 inSection:3];
                                    NSMutableArray *array=[NSMutableArray arrayWithObject:index];
                                    [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
                                    [self.tableView endUpdates];
                                    self.commentTextView.text=@"";
                                });
                                
                                                
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCommentUploadSuccessView" object:nil];
                            }
                      
                }];
                
//                [self->bmobObjectCommentArray addObject:comment];
//                [self->rowHeightArray addObject:@"80"];
//                NSLog(@"%@",[comment valueForKey:@"objectId"]);
//                [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
//                [self->commentArray addObject:[comment objectId] ];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView beginUpdates];
//                    NSIndexPath *index=[NSIndexPath indexPathForRow:self->bmobObjectCommentArray.count-1 inSection:3];
//                    NSMutableArray *array=[NSMutableArray arrayWithObject:index];
//                    [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
//                    [self.tableView endUpdates];
//                    self.commentTextView.text=@"";
//                });
//
//
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCommentUploadSuccessView" object:nil];
            }else{
                NSLog(@"%@",error);
            }
        }];
    }else{
        isReply=NO;
        [self.commentTextView resignFirstResponder];
        [self setBackCommentViewFrame];
        
        BmobObject *reply=[BmobObject objectWithClassName:@"Reply"];
        [reply setObject:[UserDefaults getUser].userId forKey:@"userID"];
        [reply setObject:self.commentTextView.text forKey:@"content"];
        [reply setObject:[UserDefaults getUser].userName forKey:@"username"];
        [reply setObject:commentArray[selectedIndexPath.item] forKey:@"commodityID"];
        [reply saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                BmobObject *comment=self->bmobObjectCommentArray[self->selectedIndexPath.item];
                [comment addObjectsFromArray:@[[reply objectId]] forKey:@"replyArray"];
                int replyCount=[[comment objectForKey:@"replyCount"] intValue]+1;
                [comment setObject:[NSString stringWithFormat:@"%d",replyCount] forKey:@"replyCount"];
                [comment updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if(isSuccessful){
                        
                        BmobQuery *bquery=[BmobQuery queryWithClassName:@"CommodityComment"];
                        [bquery whereKey:@"objectId" equalTo:[self->bmobObjectCommentArray[self->selectedIndexPath.item] objectId] ];
                        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                            if(array.count>0){
                                self->bmobObjectCommentArray[self->selectedIndexPath.item]=array[0];
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCommentReplyUploadSuccessView" object:nil];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if([[comment objectForKey:@"commentArray"] array].count <=3){
                                        CGFloat height=[self->rowHeightArray[self->selectedIndexPath.item] floatValue];
                                        self->rowHeightArray[self->selectedIndexPath.item]=[NSString stringWithFormat:@"%lf",height+20];
                                    }
                                    [self.tableView beginUpdates];
                                    [self.tableView reloadRowsAtIndexPaths:@[self->selectedIndexPath] withRowAnimation:UITableViewRowAnimationTop];
                                    [self.tableView endUpdates];
                                });
                            }
                        }];
                        
                        //elf->bmobObjectCommentArray[self->selectedIndexPath.item]=comment;
                        
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCommentReplyUploadSuccessView" object:nil];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if([[comment objectForKey:@"commentArray"] array].count <=3){
//                                CGFloat height=[self->rowHeightArray[self->selectedIndexPath.item] floatValue];
//                                self->rowHeightArray[self->selectedIndexPath.item]=[NSString stringWithFormat:@"%lf",height+20];
//                            }
//                            [self.tableView beginUpdates];
//                            [self.tableView reloadRowsAtIndexPaths:@[self->selectedIndexPath] withRowAnimation:UITableViewRowAnimationTop];
//                            [self.tableView endUpdates];
//                        });
                    }
                }];
            }else{
                NSLog(@"%@",error);
            }
        }];
        
        [self.commentTextView setText:@""];
    }
}

-(void)resetCommentViewFrame:(NSNotification *)notification{
    CGFloat keyboardY=[[notification.userInfo valueForKey:@"Y"] floatValue];
    [self.commentView setFrame:CGRectMake(0, keyboardY-50,self.bounds.size.width, 50)];
        [self.commentBtn setTitle:@"发送" forState:UIControlStateNormal];
}


-(void)setBackCommentViewFrame{
    [self.commentView setFrame:CGRectMake(0, self.bounds.size.height-70, self.bounds.size.width, 70)];
    [self.commentTextView setFrame:CGRectMake(10, 10, self.bounds.size.width-70, 30)];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        ImageScrollTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"imagecell"];
        [cell layoutWithImgCount:self.picArray.count IamgeArray:self.picArray];
        NSLog(@"1");
        return cell;
    }else if(indexPath.section==1){
        CommodityInformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"informationcell"];
        [cell layoutWithModel:self.model ifshowMore:showMore];
        [cell.layer setCornerRadius:12.0];
        return cell;
    }else if(indexPath.section==2){
        ReleasedUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"usercell"];
        [cell layoutWithModel:self.model];
        [cell.layer setCornerRadius:12.0];
        return cell;
    }else{
        CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"commentcell"];
        [cell layoutWithComment:bmobObjectCommentArray[indexPath.item]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%@",indexPath);
    if(indexPath.section==3){
        isReply=YES;
        selectedIndexPath=indexPath;
        [self.commentTextView becomeFirstResponder];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0) return 1;
    if(section==1) return 1;
    if(section==2) return 1;
    return bmobObjectCommentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) return imgViewHeight;
    if(indexPath.section == 1) return informationSectionHeight;
    if(indexPath.section == 2) return 80;
    
    CGFloat h=[rowHeightArray[indexPath.item] floatValue];
    return h;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"height");
    if(indexPath.section == 0) return imgViewHeight;
    if(indexPath.section == 1) return informationSectionHeight;
    if(indexPath.section == 2) return 80;
    
    CGFloat h=[rowHeightArray[indexPath.item] floatValue];
    return h;
}


-(void)showMore:(NSNotification *)notification{
    informationSectionHeight+=[[notification.userInfo valueForKey:@"addHeight"] floatValue];
    showMore=YES;
    NSIndexSet *index=[NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationFade];
    //[self.tableView reloadData];
}

-(void)closeShowMore:(NSNotification *)notification{
    showMore=NO;
    informationSectionHeight=80;
    NSIndexSet *index=[NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -
#pragma 记住
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        //圆率
        CGFloat cornerRadius = 12.0;
        //大小
        CGRect bounds = cell.bounds;
        //行数
        NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
        
        //绘制曲线
        UIBezierPath *bezierPath = nil;
        
        if (indexPath.row == 0 && numberOfRows == 1) {
            //一个为一组时,四个角都为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == 0) {
            //为组的第一行时,左上、右上角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == numberOfRows - 1) {
            //为组的最后一行,左下、右下角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else {
            //中间的都为矩形
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
        //cell的背景色透明
        cell.backgroundColor = [UIColor clearColor];
        //新建一个图层
        CAShapeLayer *layer = [CAShapeLayer layer];
        //图层边框路径
        layer.path = bezierPath.CGPath;
        //图层填充色,也就是cell的底色
        layer.fillColor = [UIColor whiteColor].CGColor;
        //图层边框线条颜色
        /*
         如果self.tableView.style = UITableViewStyleGrouped时,每一组的首尾都会有一根分割线,目前我还没找到去掉每组首尾分割线,保留cell分割线的办法。
         所以这里取巧,用带颜色的图层边框替代分割线。
         这里为了美观,最好设为和tableView的底色一致。
         设为透明,好像不起作用。
         */
        layer.strokeColor = [UIColor whiteColor].CGColor;
        //将图层添加到cell的图层中,并插到最底层
        [cell.layer insertSublayer:layer atIndex:0];
    }
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section==0) {
//        return ;
//    }
//    //圆率
//    CGFloat cornerRadius = 10.0;
//    //大小
//    CGRect bounds = cell.bounds;
//    //行数
//    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
//    UIView *headerView;
//    if ([self respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
//        headerView=[self tableView:tableView viewForHeaderInSection:indexPath.section];
//    }
//
//    //绘制曲线
//    UIBezierPath *bezierPath = nil;
//    if (headerView) {
//        if (indexPath.row == 0 && numberOfRows == 1) {
//            //一个为一组时，四个角都为圆角
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        }else
//        if (indexPath.row == numberOfRows - 1) {
//            //为组的最后一行，左下、右下角为圆角
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        } else {
//            //中间的都为矩形
//            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
//        }
//    }else{
//        if (indexPath.row == 0 && numberOfRows == 1) {
//            //一个为一组时，四个角都为圆角
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        } else if (indexPath.row == 0) {
//            //为组的第一行时，左上、右上角为圆角
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        } else if (indexPath.row == numberOfRows - 1) {
//            //为组的最后一行，左下、右下角为圆角
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        } else {
//            //中间的都为矩形
//            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
//        }
//    }
//
//    //新建一个图层
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    //图层边框路径
//    layer.path = bezierPath.CGPath;
//    cell.layer.mask=layer;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    //圆率
//    CGFloat cornerRadius = 8;
//    //大小
//    CGRect bounds = view.bounds;
//
//    //绘制曲线
//    UIBezierPath *bezierPath = nil;
//    //为组的第一行时，左上、右上角为圆角
//    bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//    //新建一个图层
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    //图层边框路径
//    layer.path = bezierPath.CGPath;
//    view.layer.mask=layer;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0) return 0.1;
    else return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0) return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.1)];
    else return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==3) return 0.1;
    else return 10;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0) return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.1)];
    else return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
}


@end
