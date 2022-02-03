//
//  CircleTopView.m
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import "CircleTopView.h"

@implementation CircleTopView

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HomePage) name:@"homePage" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FollowingPage) name:@"followingPage" object:nil];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGFloat Width=self.frame.size.width;
    //CGFloat Height=self.frame.size.height;
    _followingBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/2-100, 44, 100, 50)];
    [_followingBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_followingBtn addTarget:self action:@selector(followingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_followingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
    _homeBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/2, 44, 100, 50)];
    [_homeBtn setTitle:@"圈子" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [_homeBtn addTarget:self action:@selector(homeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_followingBtn];
    [self addSubview:_homeBtn];
    
}

-(void)followingBtnClick:(UIButton *)sender{
    [_followingBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [_followingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_homeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"turnToHomeView" object:nil];
}

-(void)homeBtnClick:(UIButton *)sender{
    [_homeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_followingBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_followingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"turnToFollowingView" object:nil];
}

-(void)HomePage{
    [_homeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_followingBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_followingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)FollowingPage{
    [_followingBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [_followingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_homeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

@end
