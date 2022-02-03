//
//  RegisterView.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "RegisterView.h"

@implementation RegisterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

/*
 @property (nonatomic) UIButton          *registerBtn;
 @property (nonatomic) UIButton          *zhuceBtn;
 @property (nonatomic) UILabel           *acountLabel;
 @property (nonatomic) UILabel           *passwordLabel;
 @property (nonatomic) UITextField       *acountTextField;
 @property (nonatomic) UITextField       *passwordTextField;

 */

-(void) setUI{
    //[self setBackgroundColor:[UIColor blueColor]];
    CGFloat Width=self.frame.size.width;
    CGFloat Height=self.frame.size.height;
    
    self.acountLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/4-40, Height/2-200, 40, 30)];
    self.acountLabel.text=@"账号:";
    
    self.passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/4-40, Height/2-150, 40, 30)];
    self.passwordLabel.text=@"密码:";
    
    self.acountTextField=[[UITextField alloc]initWithFrame:CGRectMake(Width/4+5, Height/2-200, Width/2-40, 30)];
    self.acountTextField.placeholder=@" 手机号/学号";
    self.acountTextField.backgroundColor=[UIColor whiteColor];
    [self.acountTextField.layer setCornerRadius:10.0];
    self.acountTextField.secureTextEntry=NO;
    
    self.acountFalseLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/2+Width/4-30, Height/2-200, Width/4, 30)];
    self.acountFalseLabel.text=@"账号错误!";
    self.acountFalseLabel.textColor=[UIColor redColor];
    
    
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(Width/4+5, Height/2-150, Width/2-40, 30)];
    self.passwordTextField.placeholder=@" 密码";
    self.passwordTextField.backgroundColor=[UIColor whiteColor];
    [self.passwordTextField.layer setCornerRadius:10.0];
    self.passwordTextField.secureTextEntry=YES;
    
    self.registerBtn =[[UIButton alloc]initWithFrame:CGRectMake(Width/4-20, Height/2-100, Width/4, 50)];
    [self.registerBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    //[self.registerBtn setBackgroundColor:[UIColor yellowColor]];
    
    
    self.zhuceBtn =[[UIButton alloc]initWithFrame:CGRectMake(Width/2+20, Height/2-100, Width/4, 50)];
    [self.zhuceBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.zhuceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhuceBtn addTarget:self action:@selector(zhuceUser) forControlEvents:UIControlEventTouchUpInside];
    //[self.zhuceBtn setBackgroundColor:[UIColor yellowColor]];
    
    
    [self addSubview:self.acountFalseLabel];
    [self addSubview:self.acountLabel];
    [self addSubview:self.passwordLabel];
    [self addSubview:self.acountTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.registerBtn];
    [self addSubview:self.zhuceBtn];
    [self.acountFalseLabel setHidden:YES];
}

-(void)registerUser{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWaitRegiserUserView" object:nil];
    
    NSString* phoneNumber=self.acountTextField.text;
    NSString* password=self.passwordTextField.text;
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
    [bquery whereKey:@"phoneNumber" equalTo:phoneNumber];
    [bquery whereKey:@"password" equalTo:password];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(array.count == 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.acountFalseLabel setHidden:NO];
            });
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"popWaitRegiserUserView" object:nil];
            BmobObject *user=array[0];
            NSDictionary *userInformation=[user valueForKey:@"dataDic"];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:phoneNumber forKey:@"phoneNumber"];
            [dic setValue:password forKey:@"password"];
            [dic setValue:[userInformation valueForKey:@"username"] forKey:@"userName"];
            [dic setValue:[userInformation valueForKey:@"objectId"] forKey:@"userId"];
            [dic setValue:[userInformation valueForKey:@"headImageUrl"] forKey:@"headImageUrl"];
            [dic setValue:[userInformation valueForKey:@"headImageUrl-C"] forKey:@"headImageUrlCompression"];
            [dic setValue:[userInformation valueForKey:@"followingCount"] forKey:@"followingCount"];
            [dic setValue:[userInformation valueForKey:@"fansCount"] forKey:@"fansCount"];
            [dic setValue:[userInformation valueForKey:@"followingUsers"] forKey:@"followingUsers"];
            [dic setValue:[userInformation valueForKey:@"fansUsers"] forKey:@"fansUsers"];
            
            
            
            UserInformationModel *model=[UserInformationModel configWithDic:dic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setUser" object:nil userInfo:@{@"model":model}];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"cancleRegisterViewController" object:nil];
            [UserDefaults deleteUser];
            [UserDefaults setUser:model];
            dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                [UserDefaults setImage:[NSData dataWithContentsOfURL: [NSURL URLWithString:model.headImageUrl]   ]];
                [UserDefaults setImageCompression:[NSData dataWithContentsOfURL: [NSURL URLWithString:model.headImageUrlCompression]   ]];
                
            });
            
            
            [[UserStatus sharedInstance] registerUser];
            [self.acountFalseLabel setHidden:YES];
        }
    }];
    
}



-(void)zhuceUser{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushZhuceViewController" object:nil];
}



@end
