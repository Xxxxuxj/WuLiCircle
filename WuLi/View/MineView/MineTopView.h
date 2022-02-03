//
//  MineTopView.h
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import <UIKit/UIKit.h>
#import "UserInformationModel.h"
#import "UserDefaults.h"
#import "UIImage+CircleImage.h"
#import "UserStatus.h"
#import <BmobSDK/Bmob.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineTopView : UIView

@property (nonatomic) UIButton      *headBtn;
@property (nonatomic) UIButton      *setBtn;
@property (nonatomic) UIButton      *registerBtn;

@property (nonatomic) UIButton      *nameBtn;
@property (nonatomic) UIButton      *fansCountBtn;
@property (nonatomic) UIButton      *followingCountBtn;

-(void) layoutWihtLocalData;
-(void)layoutIfNoUser;
-(void)layoutWithUser:(UserInformationModel *)model;
@end

NS_ASSUME_NONNULL_END
