//
//  ReleaseCommodityView.m
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import "ReleaseCommodityView.h"
@interface ReleaseCommodityView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIGestureRecognizerDelegate>
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



@implementation ReleaseCommodityView

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteAddedImage:) name:@"deleteAddedImage" object:nil];
        
        
        
        //注册通知
        //调整scrollview的contentoffset  使在输入价格的同时键盘不会挡住输入框
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pirceInput:) name:@"pirceInput" object:nil];
        
        
        
        //注册通知
        //调整scrollview的contentoffset  使在输入价格结束时回调
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pirceInputEnd:) name:@"pirceInputEnd" object:nil];
        
        
        
        //注册通知
        //键盘弹出时 给imgCollectionView添加一个手势 点击后取消三个输入框的第一响应者
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addGestureRecognizer) name:@"addGestureRecognizer" object:nil];
        
        
        
        //注册通知
        //键盘隐藏后 取消给imgCollectionView添加的手势
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeGestureRecognizer) name:@"removeGestureRecognizer" object:nil];
        
        
        
        //注册通知
        //添加信息 将输入的信息通过userinfo传入 添加至model中
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitInformation:) name:@"submitInformation" object:nil];
        
        
        
        
        
        
        //初始化postImageIndex为0
        postImageIndex      =0;
        
        
        
        //初始化model
        self.model          =[[CommodityModel alloc]init];
        //暂时使model.location为南湖
        self.model.location =@"南湖";
        
        
        
        //setUI
        [self setUI];
    }
    return self;
}




/// 注销通知
/// 不能使用 [[NSNotificationCenter defaultCenter]removeObserver:self]
/// 可能会使系统给本身的通知也注销
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"deleteAddedImage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pirceInput" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pirceInputEnd" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"addGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"submitInformation" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"commodityLocationChanged" object:nil];
    
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
    [self.imgCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titlecell"];
    //注册内容描述的cell
    [self.imgCollectionView registerClass:[TextCollectionViewCell class] forCellWithReuseIdentifier:@"textcell"];
    //注册添加图片的cell
    [self.imgCollectionView registerClass:[AddImageCollectionViewCell class] forCellWithReuseIdentifier:@"imagecell"];
    //注册商品地理位置的cell
    [self.imgCollectionView registerClass:[CommodityLocationCollectionViewCell class] forCellWithReuseIdentifier:@"locationcell"];
    //注册价格输入框的cell
    [self.imgCollectionView registerClass:[PriceCollectionViewCell class] forCellWithReuseIdentifier:@"pricecell"];
    //注册提交的cell
    [self.imgCollectionView registerClass:[SubmitCollectionViewCell class] forCellWithReuseIdentifier:@"submitcell"];
    
    
    
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
-(void)deleteAddedImage:(NSNotification *)notification{
    
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
        AddImageCollectionViewCell *cell=(AddImageCollectionViewCell *)[self.imgCollectionView cellForItemAtIndexPath:indexPath];
        cell.index--;
    }
    
}



//输入价格时
-(void)pirceInput:(NSNotification *)notification{
    
    //_keyboardY不为0 时，即得到过键盘的高度
    if(_keyboardY != 0){
        
        //得到输入价格的cell的index
        NSIndexPath *index=[NSIndexPath indexPathForItem:1 inSection:3];
        
        
        //得到cell的frame
        UICollectionViewLayoutAttributes *attributes=[self.imgCollectionView layoutAttributesForItemAtIndexPath:index];
        CGRect cellrect=attributes.frame;
        
        
        //计算偏移量
        int offset=cellrect.origin.y+cellrect.size.height - self.keyboardY;
        CGPoint point= CGPointMake(0, offset+88);
        
        //setContentOffset
        [self.mainScrollView setContentOffset:point animated:YES];
    }
    
    
}


//价格输入结束后
-(void)pirceInputEnd:(NSNotification *)notification{
    
    //回调偏移量
    [self.mainScrollView setContentOffset:CGPointZero animated:YES];
    
}


//添加手势
-(void)addGestureRecognizer{
    [self.imgCollectionView addGestureRecognizer:tap];
}


//添加手势
-(void)removeGestureRecognizer{
    [self.imgCollectionView removeGestureRecognizer:tap];
}



-(void)tapToHideKeyboard{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TextResignFirstResponder" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TitleResignFirstResponder" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PriceResignFirstResponder" object:nil];
}



//提交信息
//notification.userInfo 中传入的格式为@{@"model的参数":@"数据"}
//必须为model中的参数
-(void)submitInformation:(NSNotification *)notification{

    //得到userInfo
    NSDictionary * _Nullable dic=notification.userInfo;
    
    //传入数据至model
    [_model setValue:dic.allValues[0] forKey:dic.allKeys[0]];
    
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
    else if(section == 3) return 2;
    else return 1;
    
}




- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section==0){
        
        TitleCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"titlecell" forIndexPath:indexPath];
        return cell;
        
    }else if(indexPath.section==1){
        
        TextCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"textcell" forIndexPath:indexPath];
        return cell;
        
    }else if(indexPath.section == 2){
        
        AddImageCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"imagecell" forIndexPath:indexPath];
        
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
        
        if(indexPath.item==0){
            
            CommodityLocationCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"locationcell" forIndexPath:indexPath];
            return cell;
            
        }else{
            
            PriceCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"pricecell" forIndexPath:indexPath];
            return cell;
            
        }
        
    }else{
        
        SubmitCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"submitcell" forIndexPath:indexPath];
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushImagePickerController" object:nil];
            
        }
    }
    //选择地点
    else if(indexPath.section == 3){
        
        if(indexPath.item == 0){
            
            //alertLocationChoose
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertLocationChoose" object:nil];
        }
        
    }
    //提交
    else if(indexPath.section == 4){
        
        if(!_model.location){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertWarningNoLocation" object:nil];
        }else if(!_model.commodityTitle){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertWarningNoTitle" object:nil];
        }else if(_imgArray.count==1){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertWarningNoImage" object:nil];
        }else if(!_model.price){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alertWarningNoPrice" object:nil];
        }else{
        
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitUploadingCommodityView" object:nil];
        
        
            //得到私有目录的地址
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            //将每个图片的path存在一个array中
            NSMutableArray *filePathArray=[NSMutableArray array];
            
            //将postImageIndex之前的image都存在本地
            for(int i=0;i<postImageIndex;i++){
                
                //存放的路径
                //文件的后缀.png不可少
                NSString *filePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"CommodityImage%d.png",i] ];
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
            
            
            //压缩第一张图片并上传    
            NSData *firstPicCompression=[self.imgArray[0] compressQualityWithMaxLength:100];
            
            BmobFile *firstPicBmobFile=[[BmobFile alloc]initWithFileName:@"CommodityFirstImage.jpg" withFileData:firstPicCompression];
            __block NSString *firstPicUrl=[NSString stringWithFormat:@""];
            [firstPicBmobFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
                            if(isSuccessful){
                                firstPicUrl=firstPicBmobFile.url;
                            }
                        } withProgressBlock:^(CGFloat progress) {
                            
                        }];
            
            
            //防止循环引用
            __weak typeof(self) weakSelf=self;
            
            [BmobFile filesUploadBatchWithPaths:filePathArray progressBlock:^(int index, float progress) {
                        
                    } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
                        //array为批量上传完文件后得到的BmobFile数组
                        
                        
                        //防止循环引用
                        __strong typeof(self) strongSelf=weakSelf;
                        
                        //BmobObject
                        BmobObject *commodity=[BmobObject objectWithClassName:@"Commodity"];
                        
                        
                        //每个图片的url数组
                        NSMutableArray *picUrlArray=[NSMutableArray array];
                        for(int i=0;i<array.count;i++){
                            BmobFile *file=array[i];
                            //将BmobFile的url添加至picArray
                            [picUrlArray addObject:file.url];
                        }
                        
                        
                        
                        
                        
                        //添加数据至BmobObject（Commodity）
                        [commodity setObject:strongSelf.model.price forKey:@"price"];
                        [commodity setObject:strongSelf.model.location forKey:@"location"];
                        [commodity setObject:strongSelf.model.commodityTitle forKey:@"title"];
                        [commodity setObject:strongSelf.model.commodityDescription forKey:@"description"];
                        [commodity setObject:picUrlArray forKey:@"picArray"];
                        [commodity setObject:firstPicUrl forKey:@"firstPicUrl-C"];
                        [commodity setObject:[UserDefaults getUser].userId forKey:@"userID"];
                        [commodity setObject:[UserDefaults getUser].userName forKey:@"username"];
                        [commodity setObject:[UserDefaults getUser].headImageUrl forKey:@"headImageUrl"];
                        [commodity setObject:[UserDefaults getUser].headImageUrlCompression forKey:@"headImageUrl-C"];
                        
                        //上传commodity
                        [commodity saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            if(isSuccessful){
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCommodityView" object:nil];
                                //成功则popReleaseCommodityViewController
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"popReleaseCommodityViewController" object:nil];
                            }else{
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"popWaitUploadingCommodityView" object:nil];
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitUploadingCommodityErrorView" object:nil];
                            }
                        }];
                    }];
            

            
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
        if(indexPath.item==0){
            size=CGSizeMake(60, 40);
        }else{
            size=CGSizeMake(120, 40);
        }
    }else{
        size=CGSizeMake(self.frame.size.width-20, 50);
    }
    return size;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 3){
        return self.bounds.size.width-200;
    }
    return 10;
}

@end
