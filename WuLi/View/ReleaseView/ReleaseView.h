//
//  ReleaseView.h
//  WuLi
//
//  Created by Mac on 2021/12/11.
//

#import <UIKit/UIKit.h>
#import "chooseBubbleView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseView : UIView


//发布的backgroudView
@property (nonatomic) UIView                    *chooseView;

//发布的chooseView
@property (nonatomic) chooseBubbleView          *chooseBubbleView;


@end

NS_ASSUME_NONNULL_END
