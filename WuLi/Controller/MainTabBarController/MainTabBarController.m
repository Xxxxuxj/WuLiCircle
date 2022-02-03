//
//  MainTabBarController.m
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()<AxcAE_TabBarDelegate,TZImagePickerControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissReleaseView) name:@"dismissReleaseView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushReleaseCommodityViewController) name:@"pushReleaseCommodityViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popReleaseCommodityViewController) name:@"popReleaseCommodityViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popReleaseCircleViewController) name:@"popReleaseCircleViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushReleaseCircleViewController) name:@"pushReleaseCircleViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushImagePickerController) name:@"pushImagePickerController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCircleImagePickerController) name:@"pushCircleImagePickerController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushUserViewController:) name:@"pushUserViewController" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWaitUploadingCircleView) name:@"pushWaitUploadingCircleView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popWaitUploadingCircleView) name:@"popWaitUploadingCircleView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWaitUploadingCircleErrorView) name:@"pushWaitUploadingCircleErrorView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWaitUploadingCommodityView) name:@"pushWaitUploadingCommodityView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popWaitUploadingCommodityView) name:@"popWaitUploadingCommodityView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWaitUploadingCommodityErrorView) name:@"pushWaitUploadingCommodityErrorView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushNotRegisterView) name:@"pushNotRegisterView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCommentUploadSuccessView) name:@"pushCommentUploadSuccessView" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCommentReplyUploadSuccessView) name:@"pushCommentUploadSuccessView" object:nil];
    
    [self setUI];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setUI{
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[UIViewController new],@"normalImg":@"home_normal",@"selectImg":@"home_highlight",@"itemTitle":@"首页"},
      @{@"vc":[UIViewController new],@"normalImg":@"mycity_normal",@"selectImg":@"mycity_highlight",@"itemTitle":@"圈子"},
      @{@"vc":[UIViewController new],@"normalImg":@"",@"selectImg":@"",@"itemTitle":@"发布"},
      @{@"vc":[UIViewController new],@"normalImg":@"message_normal",@"selectImg":@"message_highlight",@"itemTitle":@"消息"},
      @{@"vc":[MineViewController new],@"normalImg":@"account_normal",@"selectImg":@"account_highlight",@"itemTitle":@"我的"}];
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor blackColor];
        model.normalColor = [UIColor blackColor];
        
        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            // 设置凸出 矩形
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = 30;
            // 设置成图片文字展示
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
            // 设置图片
            model.selectImageName = @"post_normal";
            model.normalImageName = @"post_normal";
            model.selectBackgroundColor = model.normalBackgroundColor = [UIColor clearColor];
            model.backgroundImageView.hidden = YES;
            // 设置图片大小c上下左右全边距
            model.componentMargin = UIEdgeInsetsMake(0, 0, 0, 0 );
            // 设置图片的高度为40
            model.icomImgViewSize = CGSizeMake(self.tabBar.frame.size.width / 5, 60);
            model.titleLabelSize = CGSizeMake(self.tabBar.frame.size.width / 5, 20);
            // 图文间距0
            model.pictureWordsMargin = 0;
            // 设置标题文字字号
            model.titleLabel.font = [UIFont systemFontOfSize:11];
            // 设置大小/边长 自动根据最大值进行裁切
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 5.0 ,self.tabBar.frame.size.height + 20);
        }else{  // 其他的按钮来点小动画吧
            // 来点效果好看
            model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
            // 点击背景稍微明显点吧
            model.selectBackgroundColor = AxcAE_TabBarRGBA(248, 248, 248, 1);
            model.normalBackgroundColor = [UIColor clearColor];
        }
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        vc.view.backgroundColor = [UIColor whiteColor];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 使用自定义的TabBar来帮助触发凸起按钮点击事件
    testTabBar *testtabBar = [testTabBar new];
    [self setValue:testtabBar forKey:@"tabBar"];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.mainTabBar = [AxcAE_TabBar new] ;
    self.mainTabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.mainTabBar.delegate = self;
    self.mainTabBar.backgroundColor = [UIColor whiteColor];
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.mainTabBar];
    [self addLayoutTabBar]; // 10.添加适配
}

// 9.实现代理，如下：
static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    if (index != 2) { // 不是中间的就切换
        // 通知 切换视图控制器
        [self setSelectedIndex:index];
        lastIdx = index;
    }else{ // 点击了中间的
        
        [self.mainTabBar setSelectIndex:lastIdx WithAnimation:NO]; // 换回上一个选中状态
        // 或者
//        self.axcTabBar.selectIndex = lastIdx; // 不去切换TabBar的选中状态
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了中间的,不切换视图"
//                                                                          preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSLog(@"好的！！！！");
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
        _releaseView=[[ReleaseView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:_releaseView];
        
        
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.mainTabBar){
        self.mainTabBar.selectIndex = selectedIndex;
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mainTabBar.frame = self.tabBar.bounds;
    [self.mainTabBar viewDidLayoutItems];
}


-(void)dismissReleaseView{
    [self.releaseView removeFromSuperview];
}

-(void)pushReleaseCommodityViewController{
    _releaseCommodityViewController=[[ReleaseCommodityViewController alloc]init];
    [self.navigationController pushViewController:_releaseCommodityViewController animated:YES];
}

-(void)popReleaseCommodityViewController{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissReleaseView];
}

-(void)pushReleaseCircleViewController{
    _releaseCircleViewController=[[ReleaseCircleViewController alloc]init];
    [self.navigationController pushViewController:_releaseCircleViewController animated:YES];
}

-(void)popReleaseCircleViewController{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissReleaseView];
}

-(void)pushImagePickerController{
    _imagePickerController=[[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    _imagePickerController.allowPickingVideo=NO;
    _imagePickerController.preferredLanguage=@"zh-Hans";
    _imagePickerController.showPhotoCannotSelectLayer=YES;
    
    
    __weak typeof (self) wself=self;
    [_imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        __strong typeof (self) strongself=wself;
        [strongself.releaseCommodityViewController layoutWithImageArray:photos];
    }];
    
    [_releaseCommodityViewController presentViewController:_imagePickerController animated:YES completion:^{
            
    }];
}

-(void)pushCircleImagePickerController{
    _imagePickerController=[[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    _imagePickerController.allowPickingVideo=NO;
    _imagePickerController.preferredLanguage=@"zh-Hans";
    _imagePickerController.showPhotoCannotSelectLayer=YES;
    
    
    __weak typeof (self) wself=self;
    [_imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        __strong typeof (self) strongself=wself;
        [strongself.releaseCircleViewController layoutWithImageArray:photos];
    }];
    
    [_releaseCircleViewController presentViewController:_imagePickerController animated:YES completion:^{
            
    }];
}


-(void)pushUserViewController:(NSNotification *)notification{
    NSString *userID=[notification.userInfo objectForKey:@"userID"];
    UserViewController *userController=[UserViewController new];
    [userController layoutWithUserID:userID];
    [self.navigationController pushViewController:userController animated:YES];
}



-(void)pushWaitUploadingCircleView{
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
    .wStartView(_releaseCircleViewController.view);
}

-(void)popWaitUploadingCircleView{
    [WMZDialog closeWithshowView:_releaseCircleViewController.view block:nil];
}

-(void)pushWaitUploadingCircleErrorView{
    Dialog()
    //加载框颜色
    .wLoadingColorSet([UIColor redColor])
    .wTitleSet(@"上传失败")
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleError)
    //动画时间
    .wAnimationDurtionSet(0.8)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(40, 40))
    .wStartView(_releaseCircleViewController.view);
}


-(void)pushWaitUploadingCommodityView{
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
    .wStartView(_releaseCommodityViewController.view);
}

-(void)popWaitUploadingCommodityView{
    [WMZDialog closeWithshowView:_releaseCommodityViewController.view block:nil];
}

-(void)pushWaitUploadingCommodityErrorView{
    Dialog()
    //加载框颜色
    .wLoadingColorSet([UIColor redColor])
    .wTitleSet(@"上传失败")
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleError)
    //动画时间
    .wAnimationDurtionSet(0.8)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(40, 40))
    .wStartView(_releaseCommodityViewController.view);
}


-(void)pushNotRegisterView{
    Dialog().wTypeSet(DialogTypeAuto)
    .wMessageSet(@"未登录账号")
    //自动消失时间 默认1.5
    .wDisappelSecondSet(1)
    //自定义属性
    .wMainOffsetXSet(15)
    .wMainOffsetYSet(15)
    .wShowAnimationSet(AninatonShowScaleFade)
    .wHideAnimationSet(AninatonHideScaleFade)
    .wStart();
}


-(void)pushCommentUploadSuccessView{
    Dialog()
    //加载框颜色
    .wLoadingColorSet(DialogColor(0x108ee9))
    .wTitleSet(@"评论成功")
    .wDisappelSecondSet(0.4)
    //加载框线条宽度
    .wLoadingWidthSet(2.5)
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleRight)
    //动画时间
    .wAnimationDurtionSet(0.3)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(40, 40))
    .wStart();
}



-(void)pushCommentReplyUploadSuccessView{
    Dialog()
    //加载框颜色
    .wLoadingColorSet(DialogColor(0x108ee9))
    .wTitleSet(@"回复成功")
    .wDisappelSecondSet(0.4)
    //加载框线条宽度
    .wLoadingWidthSet(2.5)
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleRight)
    //动画时间
    .wAnimationDurtionSet(0.3)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(40, 40))
    .wStart();
}



@end
