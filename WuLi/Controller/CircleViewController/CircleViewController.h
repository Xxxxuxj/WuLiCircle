//
//  CircleViewController.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>
#import "CircleTopView.h"
#import "CircleScrollView.h"


NS_ASSUME_NONNULL_BEGIN

@interface CircleViewController : UIViewController

@property (nonatomic) CircleTopView *topView;
@property (nonatomic) CircleScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
