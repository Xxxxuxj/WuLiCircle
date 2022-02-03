//
//  ReleaseView.m
//  WuLi
//
//  Created by Mac on 2021/12/11.
//

#import "ReleaseView.h"

@implementation ReleaseView

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
    
    _chooseView=[[UIView alloc]initWithFrame:self.frame];
    
    //给releaseView的backgroundView 添加一个tap手势
    //单击backgroundView 使releaseView退出
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_chooseView addGestureRecognizer:tap];
    
    
    
    _chooseView.backgroundColor=[UIColor blackColor];
    _chooseView.alpha=0.5;
    
    [self addSubview:_chooseView];

    
    self.chooseBubbleView=[[chooseBubbleView alloc]initWithFrame:CGRectMake(20, self.frame.size.height/2, self.frame.size.width-40, self.frame.size.height/2-100)];
    self.chooseBubbleView.backgroundColor=[UIColor blackColor];
    self.chooseBubbleView.alpha=1.0;
    [self addSubview:self.chooseBubbleView];
}


///单击backgroundView之后 发送通知给MainTabbarController 使releaseView退出
-(void)tap{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"dismissReleaseView" object:nil];
}



@end
