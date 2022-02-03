//
//  CircleScrollView.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"
#import "FollowingView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CircleScrollView : UIScrollView

@property (nonatomic) HomeView *homeView;
@property (nonatomic) FollowingView *followingView;

@end

NS_ASSUME_NONNULL_END
