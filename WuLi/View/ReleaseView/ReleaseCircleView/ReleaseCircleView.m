//
//  ReleaseCircleView.m
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import "ReleaseCircleView.h"

@interface ReleaseCircleView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    //添加按钮的图片
    UIImage *postImage;
    
    //添加按钮的图片在图片array的下标
    //始终为图片数组中所添加最后一张图片的下标+1
    int postImageIndex;
    
    //tap手势
    //用于取消键盘
    UITapGestureRecognizer *tap;
}
@end


@implementation ReleaseCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        //注册通知
        //删除添加的图片
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteCircleAddedImage:) name:@"deleteCircleAddedImage" object:nil];
        
        
        
        
        
        //注册通知
        //键盘弹出时 给imgCollectionView添加一个手势 点击后取消三个输入框的第一响应者
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addCircleGestureRecognizer) name:@"addCircleGestureRecognizer" object:nil];
        
        
        
        //注册通知
        //键盘隐藏后 取消给imgCollectionView添加的手势
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeCircleGestureRecognizer) name:@"removeCircleGestureRecognizer" object:nil];
        
        
        
        
        
        //注册通知
        //添加信息 将输入的信息通过userinfo传入 添加至model中
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitCircleInformation:) name:@"submitCircleInformation" object:nil];
        
        
        
        
        
        //初始化postImageIndex为0
        postImageIndex      =0;
        
        
        
        //初始化model
        self.model          =[[CircleModel alloc]init];
        
        
        self.labelArray     =[[NSMutableArray alloc]initWithObjects:@"无",@"失物招领",@"互帮互助",@"资料文件",@"校园信息",@"吃瓜群众",@"寻物启事",@"组织活动",@"信息资讯",@"社团组织", nil];
        
        
        //setUI
        [self setUI];
    }
    return self;
}




/// 注销通知
/// 不能使用 [[NSNotificationCenter defaultCenter]removeObserver:self]
/// 可能会使系统给本身的通知也注销
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"deleteCircleAddedImage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"addGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"submitCircleInformation" object:nil];
    
}




-(void)setUI{
    
    
    //初始化imgArray postImage
    self.imgArray   =[[NSMutableArray alloc]init];
    postImage       =[UIImage imageNamed:@"post_normal"];
    [_imgArray addObject:postImage ];
    

    
    //mainScrollView初始化
    self.mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 88, self.frame.size.width, self.bounds.size.height-88)];
    self.mainScrollView.contentSize=CGSizeMake(self.frame.size.width, self.bounds.size.height-88-33);
    self.mainScrollView.bounces=NO;
    //设置delegate
    self.mainScrollView.delegate=self;
    
    
    
    //UICollectionviewFlowLayout 初始化
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置边距
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    
    
    //UICollectionview初始化
    self.imgCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.bounds.size.height-88) collectionViewLayout:layout];
    //设置delegate
    self.imgCollectionView.delegate=self;
    //设置dataSource
    self.imgCollectionView.dataSource=self;
    //设置背景颜色
    self.imgCollectionView.backgroundColor=[UIColor colorWithRed:220/256.0 green:220/256.0 blue:220/256.0 alpha:1];
    
    
    
    //注册标题的cell
    [self.imgCollectionView registerClass:[CircleTitleCollectionViewCell class] forCellWithReuseIdentifier:@"titlecell"];
    //注册内容描述的cell
    [self.imgCollectionView registerClass:[CircleContentCollectionViewCell class] forCellWithReuseIdentifier:@"contentcell"];
    //注册添加图片的cell
    [self.imgCollectionView registerClass:[CircleAddImageCollectionViewCell class] forCellWithReuseIdentifier:@"imagecell"];
    //注册圈子标签的cell
    [self.imgCollectionView registerClass:[CircleLabelCollectionViewCell class] forCellWithReuseIdentifier:@"labelcell"];
    //注册提交的cell
    [self.imgCollectionView registerClass:[CircleSubmitCollectionViewCell class] forCellWithReuseIdentifier:@"submitcell"];
    
    
    
    
    //初始化tap 点击触发tapToHideKeyboard
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToHideKeyboard)];
    
    
    
    //保证imgCollectionView在mainScrollView中
    [self addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.imgCollectionView];
}


//更新imgArray
-(void)updateImageArray:(NSArray *)imgArray{
    // 判断添加进来的图片数组长度与现有的imgArray的长度加起来是否小于10
    if(self.imgArray.count + imgArray.count >10){
        
        //超过九张就弹出提示
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alertWarning" object:nil];
        
    }else{
        
        //将添加的图片数组 逐一插入到imgArray中
        for(UIImage* i in imgArray){
            [self.imgArray insertObject:i atIndex:postImageIndex];
        }
        
        
        //postImageIndex改变
        postImageIndex+=imgArray.count;
        
        
        //如果postImageIndex为9的话 需要将postImage删除
        //保证imgArray的长度始终为9
        if(postImageIndex == 9){
            [self.imgArray removeObjectAtIndex:postImageIndex];
        }
        
    }
    
    
    //刷新imgCollectionView数据
    [self.imgCollectionView reloadData];
    
}











#pragma mark -
#pragma mark NSNotification





//删除添加的图片
-(void)deleteCircleAddedImage:(NSNotification *)notification{
    
    
    
    
    
    //得到删除的图片的index
    int deleteIndex=[[notification.userInfo objectForKey:@"index"] intValue];
    
    
    //首先将下标为deleteIndex的图片从imgArray中删掉
    [self.imgArray removeObjectAtIndex:deleteIndex];
    
    //再删除imgCollectionView中对应的cell
    [self.imgCollectionView deleteItemsAtIndexPaths: @[[NSIndexPath indexPathForItem:deleteIndex inSection:2]] ];
    //[self.imgArray removeObjectAtIndex:deleteIndex];
    //这个顺序不能反，不然数据会错误
    //删除cell后cell的数量还没改变
    //先改变imgArray 然后删除cell 删除cell的方法中reloadData
    
    
    //postImageIndex--
    postImageIndex--;
    
    //在删除图片后 进行判断
    //如果imgArray的数量小于9 并且最后一个图片不是postImage的话
    //将postImage添加至imgArray
    if(self.imgArray.count <9 &&  ![[self.imgArray lastObject] isEqual:postImage] ){
        
        
        [self.imgArray insertObject:postImage atIndex:postImageIndex];
        
        //刷新imgCollectionview
        [self.imgCollectionView reloadData];
    }
    
    for(int i=deleteIndex;i<postImageIndex;i++){
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:2];
        CircleAddImageCollectionViewCell *cell=(CircleAddImageCollectionViewCell *)[self.imgCollectionView cellForItemAtIndexPath:indexPath];
        cell.index--;
    }
    
    
}




//添加手势
-(void)addCircleGestureRecognizer{
    [self.imgCollectionView addGestureRecognizer:tap];
}


//添加手势
-(void)removeCircleGestureRecognizer{
    [self.imgCollectionView removeGestureRecognizer:tap];
}



-(void)tapToHideKeyboard{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CircleTextResignFirstResponder" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CircleTitleResignFirstResponder" object:nil];
}



//提交信息
//notification.userInfo 中传入的格式为@{@"model的参数":@"数据"}
//必须为model中的参数
-(void)submitCircleInformation:(NSNotification *)notification{

    //得到userInfo
    NSDictionary * _Nullable dic=notification.userInfo;
    
    //传入数据至model
    [_model setValue:dic.allValues[0] forKey:dic.allKeys[0]];
    
}



-(void)addWaitProgressView{
    Dialog()
    .wLoadingColorSet(DialogColor(0xFF9900))
    .wTitleSet(@"上传中...")
    .wTypeSet(DialogTypeLoading)
    .wLoadingTypeSet(LoadingStyleWait)
    .wShadowAlphaSet(0.01)
    .wShowCloseSet(NO)
    .wHideAnimationSet(AninatonHideNone)
    .wAnimationDurtionSet(1)
    .wLoadingSizeSet(CGSizeMake(50, 50))
    .wTagSet(222)
    .wStartView(self);
}

-(void)removeWaitProgressView{
    [WMZDialog closeWithshowView:self block:nil];
}













#pragma mark -
#pragma mark UICollectionViewDatasource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section == 0) return 1;
    else if(section == 1) return 1;
    else if(section == 2) return self.imgArray.count;
    else if(section == 3) return self.labelArray.count;
    else return 1;
    
}




- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section==0){
        
        CircleTitleCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"titlecell" forIndexPath:indexPath];
        return cell;
        
    }else if(indexPath.section==1){
        
        CircleContentCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"contentcell" forIndexPath:indexPath];
        return cell;
        
    }else if(indexPath.section == 2){
        
        CircleAddImageCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"imagecell" forIndexPath:indexPath];
        
        //如果是添加图片的按钮 则不应该添加删除按钮在右上方
        if(indexPath.item != postImageIndex ){
            
            //对cell进行布局 传入image和index
            [cell layoutWithImage:[self.imgArray objectAtIndex:indexPath.item] index:indexPath.item];
            
        }else{
            
            //如果index为-1 则不会添加一个删除按钮在右上方
            [cell layoutWithImage:[self.imgArray objectAtIndex:indexPath.item] index:-1];
            
        }
        
        return cell;
        
    }else if(indexPath.section == 3){
        
        CircleLabelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"labelcell" forIndexPath:indexPath];
        [cell setLabelText:self.labelArray[indexPath.item]];
        
        return cell;
        
    }else{
        
        CircleSubmitCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"submitcell" forIndexPath:indexPath];
        return cell;
        
    }
    
}


#pragma mark -
#pragma mark UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //添加图片
    if(indexPath.section == 2){
        //点击postImage时
        if(indexPath.item==postImageIndex){
            
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"resignFirstResponder" object:nil];
            
            
            //pushImagePickerController
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCircleImagePickerController" object:nil];
            
        }
    }else if(indexPath.section == 3){
        [_model.labelArray addObject:self.labelArray[indexPath.item]];
    }
    
    //提交
    else if(indexPath.section == 4){
        
        
        
        
        if(!_model.circleTitle){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertCircleNoTitle" object:nil];
        }else{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitUploadingCircleView" object:nil];
            
            if(self.imgArray.count==1){
                //BmobObject
                BmobObject *circle=[BmobObject objectWithClassName:@"Circle"];
                
                
                
                
                //添加数据至BmobObject（Commodity）
                [circle setObject:self.model.circleTitle forKey:@"title"];
                [circle setObject:self.model.circleContent forKey:@"content"];
                [circle setObject:self.model.labelArray forKey:@"labelArray"];
                [circle setObject:[UserDefaults getUser].userId forKey:@"userID"];
                
                //上传commodity
                [circle saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if(isSuccessful){
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCircleView" object:nil];
                        //成功则popReleaseCommodityViewController
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"popReleaseCircleViewController" object:nil];
                        
                    }else{
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCircleView" object:nil];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitUploadingCircleErrorView" object:nil];
                    }
                }];
            }else{
        
        
        
                //得到私有目录的地址
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
                //将每个图片的path存在一个array中
                NSMutableArray *filePathArray=[NSMutableArray array];
                
                //将postImageIndex之前的image都存在本地
                for(int i=0;i<postImageIndex;i++){
                    
                    //存放的路径
                    //文件的后缀.png不可少
                    NSString *filePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"CircleImage%d.png",i] ];
                    [filePathArray addObject:filePath];
                    
                }
                
                
                //如果postImageIndex存在
                if(postImageIndex <=8){
                    
                    NSMutableArray *array=[[NSMutableArray alloc]init];
                    for(int i=0;i<self.imgArray.count-1;i++){
                        
                        //将UIImage转为NSData
                        NSData *data=UIImagePNGRepresentation(self.imgArray[i]);
                        //将data写入文件路径
                        [data writeToFile:filePathArray[i] atomically:NO];
                        //将data添加至array
                        [array addObject:data];
                        
                    }
                    
                    _model.picArray=array;
                    
                }else{
                    
                    NSMutableArray *array=[[NSMutableArray alloc]init];
                    for(int i=0;i<self.imgArray.count;i++){
                        
                        //将UIImage转为NSData
                        NSData *data=UIImagePNGRepresentation(self.imgArray[i]);
                        //将data写入文件路径
                        [data writeToFile:filePathArray[i] atomically:NO];
                        //将data添加至array
                        [array addObject:data];
                        
                    }
                    
                    _model.picArray=array;
                }
                
                
                
                
                //防止循环引用
                __weak typeof(self) weakSelf=self;
                
                [BmobFile filesUploadBatchWithPaths:filePathArray progressBlock:^(int index, float progress) {
                            
                        } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
                            //array为批量上传完文件后得到的BmobFile数组
                            
                            
                            //防止循环引用
                            __strong typeof(self) strongSelf=weakSelf;
                            
                            //BmobObject
                            BmobObject *circle=[BmobObject objectWithClassName:@"Circle"];
                            
                            
                            //每个图片的url数组
                            NSMutableArray *picUrlArray=[NSMutableArray array];
                            for(int i=0;i<array.count;i++){
                                BmobFile *file=array[i];
                                //将BmobFile的url添加至picArray
                                [picUrlArray addObject:file.url];
                            }
                            
                            
                            //添加数据至BmobObject（Commodity）
                            [circle setObject:strongSelf.model.circleTitle forKey:@"title"];
                            [circle setObject:strongSelf.model.circleContent forKey:@"content"];
                            [circle setObject:strongSelf.model.labelArray forKey:@"labelArray"];
                            [circle setObject:picUrlArray forKey:@"picArray"];
                            [circle setObject:[UserDefaults getUser].userId forKey:@"userID"];
                            
                            //上传commodity
                            [circle saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                if(isSuccessful){
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCircleView" object:nil];
                                    //成功则popReleaseCommodityViewController
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"popReleaseCircleViewController" object:nil];
                                }else{
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCircleView" object:nil];
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitUploadingCircleErrorView" object:nil];
                                }
                            }];
                        }];
        
            }
        
        }
        
    }
    
}



#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size=CGSizeZero;
    if(indexPath.section == 0){
        size=CGSizeMake(self.frame.size.width-20, 50);
    }else if(indexPath.section == 1){
        size=CGSizeMake(self.frame.size.width-20, 150);
    }else if(indexPath.section == 2){
        size=CGSizeMake((self.frame.size.width-60)/3, (self.frame.size.width-60)/3);
    }else if(indexPath.section == 3){
        size=CGSizeMake(60, 30);
    }else{
        size=CGSizeMake(self.frame.size.width-20, 50);
    }
    return size;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}





@end
