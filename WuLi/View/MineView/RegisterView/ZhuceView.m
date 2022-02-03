//
//  ZhuceView.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "ZhuceView.h"

@implementation ZhuceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 @property (nonatomic) UIButton          *zhuceBtn;
 @property (nonatomic) UILabel           *acountLabel;
 @property (nonatomic) UILabel           *passwordLabel;
 @property (nonatomic) UITextField       *acountTextField;
 @property (nonatomic) UITextField       *passwordTextField;
 */

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGFloat Width=self.frame.size.width;
    CGFloat Height=self.frame.size.height;
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/4-60, Height/2-250, 60, 30)];
    self.nameLabel.text=@"用户名:";
    
    self.acountLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/4-40, Height/2-200, 40, 30)];
    self.acountLabel.text=@"账号:";
    
    self.passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/4-40, Height/2-150, 40, 30)];
    self.passwordLabel.text=@"密码:";
    
    self.nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(Width/4+5, Height/2-250, Width/2-40, 30)];
    self.nameTextField.placeholder=@" 用户名";
    self.nameTextField.backgroundColor=[UIColor whiteColor];
    [self.nameTextField.layer setCornerRadius:10.0];
    self.nameTextField.secureTextEntry=NO;
    
    self.acountTextField=[[UITextField alloc]initWithFrame:CGRectMake(Width/4+5, Height/2-200, Width/2-40, 30)];
    self.acountTextField.placeholder=@" 手机号/学号";
    self.acountTextField.backgroundColor=[UIColor whiteColor];
    [self.acountTextField.layer setCornerRadius:10.0];
    self.acountTextField.secureTextEntry=NO;
    
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(Width/4+5, Height/2-150, Width/2-40, 30)];
    self.passwordTextField.placeholder=@" 密码";
    self.passwordTextField.backgroundColor=[UIColor whiteColor];
    [self.passwordTextField.layer setCornerRadius:10.0];
    self.passwordTextField.secureTextEntry=YES;
    
    
    self.zhuceBtn =[[UIButton alloc]initWithFrame:CGRectMake(Width/4-20, Height/2-100, Width/4, 50)];
    [self.zhuceBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.zhuceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhuceBtn addTarget:self action:@selector(zhuceUser) forControlEvents:UIControlEventTouchUpInside];
    //[self.zhuceBtn setBackgroundColor:[UIColor yellowColor]];
    
    self.cancleBtn =[[UIButton alloc]initWithFrame:CGRectMake(Width/2+20, Height/2-100, Width/4, 50)];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    
    self.acountFalseLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/2+Width/4-30, Height/2-200, Width/4+10, 30)];
    self.acountFalseLabel.text=@"账号已存在!";
    self.acountFalseLabel.textColor=[UIColor redColor];
    self.acountFalseLabel.numberOfLines=2;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameTextField];
    [self addSubview:self.acountLabel];
    [self addSubview:self.passwordLabel];
    [self addSubview:self.acountTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.zhuceBtn];
    [self addSubview:self.cancleBtn];
    [self addSubview:self.acountFalseLabel];
    [self.acountFalseLabel setHidden:YES];
}

-(void)zhuceUser{
    NSString* phoneNumber=self.acountTextField.text;
    NSString* password=self.passwordTextField.text;
    NSString* name=self.nameTextField.text;
    BmobQuery *query=[BmobQuery queryWithClassName:@"User"];
    [query whereKey:@"phoneNumber" equalTo:phoneNumber];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(array.count == 0){
            [self.acountFalseLabel setHidden:YES];
            BmobObject *user = [BmobObject objectWithClassName:@"User"];
            [user setObject:phoneNumber forKey:@"phoneNumber"];
            [user setObject:password forKey:@"password"];
            [user setObject:name forKey:@"username"];
            [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                //进行操作
                if(isSuccessful){
                    [self cancle];
                }
            }];
        }else{
            [self.acountFalseLabel setHidden:NO];
        }
    }] ;
    
    
    
}

-(void)cancle{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cancleZhuceViewController" object:nil];
}

@end
