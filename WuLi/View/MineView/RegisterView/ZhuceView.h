//
//  ZhuceView.h
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZhuceView : UIView

@property (nonatomic) UIButton          *zhuceBtn;
@property (nonatomic) UIButton          *cancleBtn;
@property (nonatomic) UILabel           *nameLabel;
@property (nonatomic) UILabel           *acountLabel;
@property (nonatomic) UILabel           *passwordLabel;
@property (nonatomic) UILabel           *acountFalseLabel;
@property (nonatomic) UILabel           *passwordFalseLabel;
@property (nonatomic) UITextField       *nameTextField;
@property (nonatomic) UITextField       *acountTextField;
@property (nonatomic) UITextField       *passwordTextField;

@end

NS_ASSUME_NONNULL_END
