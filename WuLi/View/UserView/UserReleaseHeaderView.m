//
//  UserReleaseHeaderView.m
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import "UserReleaseHeaderView.h"

@implementation UserReleaseHeaderView

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

-(void)setUI{
    UIButton *commodityBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height-10)];
    [commodityBtn setTitle:@"商品" forState:UIControlStateNormal];
    [commodityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commodityBtn addTarget:self action:@selector(commodityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *circleBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height-10)];
    [circleBtn setTitle:@"圈子" forState:UIControlStateNormal];
    [circleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(circleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.backgroundColor=[UIColor whiteColor];
    [self addSubview:commodityBtn];
    [self addSubview:circleBtn];
}

-(void)commodityBtnClick:(UIButton *)sender{
    
}

-(void)circleBtnClick:(UIButton *)sender{
    
}


@end
