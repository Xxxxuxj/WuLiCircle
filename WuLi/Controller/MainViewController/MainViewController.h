//
//  ViewController.h
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import <UIKit/UIKit.h>
#import <ZQSearchViewController.h>
#import "MainTopView.h"
#import "RecommendView.h"
#import "MainScrollView.h"
#import "CommodityDetailViewController.h"
#import <BmobSDK/Bmob.h>

@interface MainViewController : UIViewController

@property (nonatomic,strong) MainTopView                *topView;
@property (nonatomic,strong) MainScrollView              *mainScrollView;
@property (nonatomic,strong) ZQSearchViewController     *searchViewController;
@property (nonatomic,strong) UIScrollView               *showScrollView;

@end

