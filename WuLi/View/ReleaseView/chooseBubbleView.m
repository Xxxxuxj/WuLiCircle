//
//  chooseBubbleView.m
//  WuLi
//
//  Created by Mac on 2021/12/11.
//

#import "chooseBubbleView.h"

@implementation chooseBubbleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//
//}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGFloat Width=self.frame.size.width;
    CGFloat Height=self.frame.size.height;
    
    
    _releaseCommodityBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, Height/4, Width/2-20, Height/2)];
    _releaseCommodityBtn.backgroundColor=[UIColor blueColor];
    [_releaseCommodityBtn setTitle:@"商品" forState:UIControlStateNormal];
    [_releaseCommodityBtn addTarget:self action:@selector(releaseCommodity) forControlEvents:UIControlEventTouchUpInside];
    
    
    _releaseCircleBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10 , Height/4, Width/2-20, Height/2)];
    _releaseCircleBtn.backgroundColor=[UIColor blueColor];
    [_releaseCircleBtn setTitle:@"圈子" forState:UIControlStateNormal];
    [_releaseCircleBtn addTarget:self action:@selector(releaseCircle) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_releaseCommodityBtn];
    [self addSubview:_releaseCircleBtn];
    
    
}


//发送通知 使MainTabBarController pushReleaseCommodityViewController
-(void)releaseCommodity{
    if([[UserStatus sharedInstance]getUserStatus]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushReleaseCommodityViewController" object:nil ];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotRegisterView" object:nil ];
    }
    
}


//发送通知 使MainTabBarController pushReleaseCircleViewController
-(void)releaseCircle{
    if([[UserStatus sharedInstance]getUserStatus]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushReleaseCircleViewController" object:nil ];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotRegisterView" object:nil ];
    }
}


@end
