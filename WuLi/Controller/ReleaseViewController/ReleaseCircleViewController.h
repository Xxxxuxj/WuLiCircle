//
//  ReleaseCircleViewController.h
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import <UIKit/UIKit.h>
#import "ReleaseCircleView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseCircleViewController : UIViewController

@property (nonatomic) ReleaseCircleView     *releaseCircleView;



-(void)layoutWithImageArray:(NSArray *)imgArray;

@end

NS_ASSUME_NONNULL_END
