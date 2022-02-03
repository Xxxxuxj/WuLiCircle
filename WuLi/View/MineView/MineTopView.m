//
//  MineTopView.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "MineTopView.h"

@implementation MineTopView

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setHeadImage:) name:@"setHeadImage" object:nil];
        [self layoutIfNoUser];
    }
    return self;
}

-(void)layoutIfNoUser{
    self.setBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width- 40, 10, 30, 30)];
    [self.setBtn setBackgroundColor:[UIColor orangeColor]];
    [self.setBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headBtn setImage:[[UIImage imageNamed:@"NoUserHeadImage"] circleImage] forState:UIControlStateNormal];
    self.headBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50,20, 100, 100)];
    self.headBtn.backgroundColor=[UIColor blackColor];
    [self.headBtn addTarget:self action:@selector(headImagePick) forControlEvents:UIControlEventTouchUpInside];
    [self.headBtn.layer setCornerRadius:50];

    
    self.registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 130, 100, 30)];
    [self.registerBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor blackColor]];
    [self.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    [self addSubview:self.setBtn];
    [self addSubview:self.headBtn];
    [self addSubview:self.registerBtn];


    
}
-(void) layoutWihtLocalData{
    if([UserDefaults getUser]){
        [[UserStatus sharedInstance] registerUser];
        [self layoutWithLocalUser:[UserDefaults getUser]];
        [self.headBtn setImage:[[UserDefaults getImage] circleImage] forState:UIControlStateNormal];
    }else{
        [self layoutWithNoUser];
    }
}
-(void)layoutWithLocalUser:(UserInformationModel *)model{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.registerBtn setHidden:YES];
        self.nameBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 130, 100, 30)];
        [self.nameBtn setBackgroundColor:[UIColor blackColor]];
        self.nameBtn.titleLabel.textColor=[UIColor whiteColor];
        self.nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.followingCountBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 160, 50, 30)];
        [self.followingCountBtn setBackgroundColor:[UIColor blackColor]];
        self.followingCountBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.followingCountBtn.titleLabel.textColor=[UIColor whiteColor];
        self.followingCountBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.fansCountBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 160, 50, 30)];
        [self.fansCountBtn setBackgroundColor:[UIColor blackColor]];
        self.fansCountBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.fansCountBtn.titleLabel.textColor=[UIColor whiteColor];
        self.fansCountBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        
        int fansCount=0,followingCount=0;
        if(![model.fansCount isEqualToString:@""]) fansCount=[model.fansCount intValue];
        if(![model.followingCount isEqualToString:@""]) followingCount=[model.followingCount intValue];
        
        [self.followingCountBtn  setTitle:[NSString stringWithFormat:@"关注:%d",followingCount] forState:UIControlStateNormal];
        [self.fansCountBtn       setTitle:[NSString stringWithFormat:@"粉丝:%d",fansCount] forState:UIControlStateNormal];
        
        
        
        [self.nameBtn setTitle:model.userName forState:UIControlStateNormal];
        
        [self addSubview:self.nameBtn];
        [self addSubview:self.followingCountBtn];
        [self addSubview:self.fansCountBtn];
        //[model addObserver:self forKeyPath:@"headImageUrl" options:NSKeyValueObservingOptionNew context:nil];
    });
    
}

-(void)layoutWithUser:(UserInformationModel *)model{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.registerBtn setHidden:YES];
        self.nameBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 130, 100, 30)];
        [self.nameBtn setBackgroundColor:[UIColor blackColor]];
        self.nameBtn.titleLabel.textColor=[UIColor whiteColor];
        self.nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.followingCountBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 160, 50, 30)];
        [self.followingCountBtn setBackgroundColor:[UIColor blackColor]];
        self.followingCountBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.followingCountBtn.titleLabel.textColor=[UIColor whiteColor];
        self.followingCountBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.fansCountBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 160, 50, 30)];
        [self.fansCountBtn setBackgroundColor:[UIColor blackColor]];
        self.fansCountBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.fansCountBtn.titleLabel.textColor=[UIColor whiteColor];
        self.fansCountBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        
        int fansCount=0,followingCount=0;
        if(![model.fansCount isEqualToString:@""]) fansCount=[model.fansCount intValue];
        if(![model.followingCount isEqualToString:@""]) followingCount=[model.followingCount intValue];

        
        [self.followingCountBtn  setTitle:[NSString stringWithFormat:@"关注:%d",followingCount] forState:UIControlStateNormal];
        [self.fansCountBtn       setTitle:[NSString stringWithFormat:@"粉丝:%d",fansCount] forState:UIControlStateNormal];
        
        [self.nameBtn setTitle:model.userName forState:UIControlStateNormal];
        
        [self addSubview:self.nameBtn];
        [self addSubview:self.followingCountBtn];
        [self addSubview:self.fansCountBtn];
        
        if(![model.headImageUrlCompression isEqualToString:@""]){
            NSLog(@"%@",model.headImageUrlCompression);
            NSURL *url=[NSURL URLWithString:model.headImageUrlCompression];
            NSData *data=[NSData dataWithContentsOfURL:url];
            
            [self.headBtn setImage:[[UIImage imageWithData:data] circleImage] forState:UIControlStateNormal];
            [UserDefaults setImage:data];
        }else{
            [self.headBtn setImage:[[UIImage imageNamed:@"NoUserHeadImage"] circleImage] forState:UIControlStateNormal];
        }
        
        
        //[model addObserver:self forKeyPath:@"headImageUrl" options:NSKeyValueObservingOptionNew context:nil];
    });
    
}

-(void)layoutWithNoUser{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.nameBtn setHidden:YES];
        [self.followingCountBtn setHidden:YES];
        [self.fansCountBtn setHidden:YES];
        [self.registerBtn setHidden:NO];
        [self.headBtn setImage:[[UIImage imageNamed:@"NoUserHeadImage"]circleImage] forState:UIControlStateNormal];
        
    });
}

-(void)registerUser{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushRegisterViewController" object:nil];
}

-(void)headImagePick{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"headImagePick" object:nil];
    //如果还有操作是同步还是异步？
}

-(void)setHeadImage:(NSNotification *)notification{
    NSString* path=[notification.userInfo objectForKey:@"path"];
    [self.headBtn setImage:[[UIImage imageWithContentsOfFile:path] circleImage] forState:UIControlStateNormal];

    
}

-(void)setting{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushSetViewController" object:nil];
}



@end
