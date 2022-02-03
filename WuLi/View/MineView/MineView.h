//
//  MineView.h
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import <UIKit/UIKit.h>
#import "MineTopView.h"
#import "UserStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineView : UIView
@property (nonatomic) MineTopView               *topView;

-(void) layoutWihtLocalData;
@end

NS_ASSUME_NONNULL_END
