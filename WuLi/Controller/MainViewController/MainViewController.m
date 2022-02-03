//
//  ViewController.m
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import "MainViewController.h"

@interface MainViewController ()<ZQSearchViewDelegate>

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.userInteractionEnabled=NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    [self.navigationController.navigationBar setHidden:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchControllerPushed) name:@"searchControllerPushed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushDetailViewController:) name:@"pushDetailViewController" object:nil];
    
    self.topView=[[MainTopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [self.view addSubview:self.topView];
    
    self.mainScrollView=[[MainScrollView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150)];
    [self.view addSubview:self.mainScrollView];
    

    
}

-(void)pushDetailViewController:(NSNotification *)notification{
    CommodityModel* model=[[notification userInfo] valueForKey:@"model"];
    CommodityDetailViewController *controller=[[CommodityDetailViewController alloc]initWithModel:model];
    
    [self.navigationController pushViewController:controller animated:YES];
}




-(void)searchControllerPushed{
    //热门搜索
    NSArray *hots = @[@"热门",@"热门热门",@"热门热门热门",@"热门热门",@"热门",@"热门",@"热热门热门热门门"];
    
    UIViewController *resultController = [UIViewController new];
    
    ZQSearchViewController *vc = [[ZQSearchViewController alloc] initSearchViewWithHotDatas:hots resultController:resultController];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
//    UIViewController* v=[UIViewController new];
//    [self.navigationController pushViewController:v animated:YES];
}



- (void)searchEditViewRefreshWithKeyString:(NSString *)keyString DataBlock:(void (^)(id))block {
//异步调用搜索接口。
}

//模糊搜索结果列表，显示在传入的resultController
- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController{
    //1 搜索关键字
    NSLog(@"%@",keyString);
    //2 搜索返回数据（需遵守<ZQSearchData>协议，可自行扩展）
    NSLog(@"%@",data);
    //3 刷新resultController
    //[resultController reloadData];
}

//精确搜索回调
- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController {
//可以将结果自定义处理。
//ResultViewController *vc = [ResultViewController new];
//[resultController.navigationController pushViewController:vc animated:YES];
}

@end
