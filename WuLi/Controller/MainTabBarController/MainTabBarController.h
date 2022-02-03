//
//  MainTabBarController.h
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import <UIKit/UIKit.h>
#import <AxcAE_TabBar/AxcAE_TabBar.h>
#import "testTabBar.h"
#import "MineViewController.h"
#import "ReleaseView.h"
#import "ReleaseCommodityViewController.h"
#import "ReleaseCircleViewController.h"
#import "TZImagePickerController.h"
#import "WMZDialog.h"
#import "UserViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarController : UITabBarController

@property (nonatomic,strong) AxcAE_TabBar                                   *mainTabBar;
@property (nonatomic,strong) ReleaseView                                    *releaseView;

@property (nonatomic,strong) TZImagePickerController                        *imagePickerController;
@property (nonatomic,strong) ReleaseCommodityViewController                 *releaseCommodityViewController;
@property (nonatomic,strong) ReleaseCircleViewController                    *releaseCircleViewController;

@end

NS_ASSUME_NONNULL_END
