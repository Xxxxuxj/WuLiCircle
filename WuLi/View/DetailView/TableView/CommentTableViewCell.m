//
//  CommentTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
- (void)setFrame:(CGRect)frame {

    frame.size.width =[UIScreen mainScreen].bounds.size.width;

    [super setFrame:frame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUI];
    }
    return self;
}


-(void)setUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headImageBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, self.frame.size.width/2-50, 20)];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    self.nameLabel.textAlignment=NSTextAlignmentLeft;
    [self.nameLabel setTextColor:[UIColor grayColor]];
    
    self.likeBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-40, 5, 20, 20)];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"like_normal"] forState:UIControlStateNormal];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"like_highlighted"] forState:UIControlStateHighlighted];
    [self.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-15, 5, 10, 15)];
    self.likeCountLabel.textColor=[UIColor redColor];
    self.likeCountLabel.text=@"0";
    [self.likeCountLabel sizeToFit];
    
    self.replyLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, self.frame.size.width-60, 40)];
    self.replyLabel.font=[UIFont systemFontOfSize:12];
    self.replyLabel.textAlignment=NSTextAlignmentLeft;
    self.replyLabel.numberOfLines=3;
    [self.replyLabel setTextColor:[UIColor grayColor]];
    
    [self.contentView addSubview:self.headImageBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.replyLabel];
    [self.contentView addSubview:self.likeCountLabel];
    
    _replyCount=0;
}


-(void)likeBtnClick:(UIButton *)sender{
    if([[UserStatus sharedInstance] getUserStatus]){
        if([sender isSelected]){
            [sender setSelected:NO];
            [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"like_normal"] forState:UIControlStateNormal];
            [[UserStatus sharedInstance]cancleLikeComment:_comment];
            NSInteger likeCount=[self.likeCountLabel.text integerValue];
            self.likeCountLabel.text=[NSString stringWithFormat:@"%ld",likeCount-1];
        }else{
            [sender setSelected:YES];
            [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"like_highlighted"] forState:UIControlStateNormal];
            [[UserStatus sharedInstance]likeComment:_comment];
            NSInteger likeCount=[self.likeCountLabel.text integerValue];
            self.likeCountLabel.text=[NSString stringWithFormat:@"%ld",likeCount+1];
        }
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotRegisterView" object:nil ];
    }
}



-(void)layoutWithComment:(BmobObject *)comment{
    self.comment=comment;
    if([[comment objectForKey:@"userID"] isEqualToString:[UserDefaults getUser].userId ]){
        [self.headImageBtn setBackgroundImage:[[UserDefaults getImageCompression] circleImage] forState:UIControlStateNormal];
        //还有一些操作 比如删除功能
    }else{
        dispatch_queue_t queue=dispatch_queue_create("setCommentHeadImage", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            NSURL *url=[NSURL URLWithString:[comment objectForKey:@"headImageUrl-C"]];
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImage *image=[UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.headImageBtn setBackgroundImage:[image circleImage] forState:UIControlStateNormal];
            });
            
        });
    }
    self.nameLabel.text=[comment objectForKey:@"username"];
    self.replyLabel.text=[comment objectForKey:@"content"];
    if([comment objectForKey:@"likeCount"]){
        self.likeCountLabel.text=[comment objectForKey:@"likeCount"];
        NSArray *likeUsers=[comment objectForKey:@"likeUsers"];
        if([likeUsers containsObject:[UserDefaults getUser].userId]){
            [self.likeBtn setSelected:YES];
            [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"like_highlighted"] forState:UIControlStateNormal];
        }
    }
    

    NSInteger Count =[[comment objectForKey:@"replyCount"] integerValue];
    _replyArray=[[NSMutableArray alloc]init];
    if(Count != _replyCount){
        _replyCount=Count;
        if(_replyCount >= 1 ){
            if(_replyCount <=3 ){
                self.replyView=[[UIView alloc]initWithFrame:CGRectMake(50, 80, self.frame.size.width-60, 20*(_replyCount+1))];
                self.replyView.backgroundColor=[UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
                
                NSArray *tempArray=[[NSArray alloc]init];

                tempArray=[comment objectForKey:@"replyArray"];

                for(int i=0;i<_replyCount;i++){
                    
                    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Reply"];
                    [bquery whereKey:@"objectId" equalTo:tempArray[i]];
                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array){
                            [self->_replyArray addObject:[array firstObject]];
                        }
                        if(self->_replyArray.count == self->_replyCount){
                            for(int j=0;j<self->_replyCount;j++){
                                UIButton *nameBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 10+j*20, self.frame.size.width-50, 20)];
                                nameBtn.tag=j;
                                [nameBtn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                [nameBtn setTitle:[NSString stringWithFormat:@"%@:%@",[self->_replyArray[j] objectForKey:@"username"],[self->_replyArray[j] objectForKey:@"content"]] forState:UIControlStateNormal];
                                [nameBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                                [nameBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                                
                                [nameBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
                                nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.replyView addSubview:nameBtn];
                                });
                            }
                        }
                    }];
                    
                }
                [self.contentView addSubview:self.replyView];
            }else{
                self.replyView=[[UIView alloc]initWithFrame:CGRectMake(50, 80, self.frame.size.width-60, 100)];
                self.replyView.backgroundColor=[UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
                
                NSArray *tempArray=[[NSArray alloc]init];

                tempArray=[comment objectForKey:@"replyArray"];

                for(int i=0;i<3;i++){
                    
                    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Reply"];
                    [bquery whereKey:@"objectId" equalTo:tempArray[i]];
                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array){
                            [self->_replyArray addObject:[array firstObject]];
                        }
                        if(self->_replyArray.count == 3){
                            for(int j=0;j<3;j++){
                                UIButton *nameBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 10+j*20, self.frame.size.width-50, 20)];
                                nameBtn.tag=j;
                                [nameBtn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                [nameBtn setTitle:[NSString stringWithFormat:@"%@:%@",[self->_replyArray[j] objectForKey:@"username"],[self->_replyArray[j] objectForKey:@"content"]] forState:UIControlStateNormal];
                                [nameBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                                [nameBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                                
                                [nameBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
                                nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.replyView addSubview:nameBtn];
                                });
                            }
                            self.moreReplyBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 70,self.frame.size.width-50, 20)];
                            [self.moreReplyBtn addTarget:self action:@selector(moreReply) forControlEvents:UIControlEventTouchUpInside];
                            [self.moreReplyBtn setTitle:@"查看更多回复" forState:UIControlStateNormal];
                            [self.moreReplyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                            [self.moreReplyBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
                            self.moreReplyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
                            self.moreReplyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            [self.replyView addSubview:self.moreReplyBtn];
                            
                        }
                    }];
                }
                
                [self.contentView addSubview:self.replyView];
            }
        }
    }
    
}

-(void)nameBtnClick:(UIButton *)sender{
    
}

-(void)moreReply{
    
}


@end
