//
//  RegisterView.h
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "UserInformationModel.h"
#import "UserDefaults.h"
#import "UserStatus.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView

@property (nonatomic) UIButton          *registerBtn;
@property (nonatomic) UIButton          *zhuceBtn;
@property (nonatomic) UILabel           *acountFalseLabel;
@property (nonatomic) UILabel           *acountLabel;
@property (nonatomic) UILabel           *passwordLabel;
@property (nonatomic) UITextField       *acountTextField;
@property (nonatomic) UITextField       *passwordTextField;


@end

NS_ASSUME_NONNULL_END
