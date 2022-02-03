//
//  MainScrollView.m
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import "MainScrollView.h"

@implementation MainScrollView

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
        self.contentSize=CGSizeMake(frame.size.width*2, frame.size.height);
        self.pagingEnabled=YES;
        self.contentOffset=CGPointMake(frame.size.width, 0);
        self.bounces=NO;
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        self.showsVerticalScrollIndicator=FALSE;
        self.showsHorizontalScrollIndicator=FALSE;
        [self setUI];
    }
    return self;
}


- (void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)setUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(turnToRecommendView) name:@"turnToRecommendView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(turnToLocationView) name:@"turnToLocationView" object:nil];
    self.recommendView=[[RecommendView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.recommendView];
    self.locationView=[[LocationView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.locationView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint offset= [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    //NSLog(@"%f",offset.x);
    if(offset.x <= 0){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"locationPage" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadDataToShow" object:nil];
    }else if(offset.x >= [UIScreen mainScreen].bounds.size.width){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"recommendPage" object:nil];
    }
}

-(void)turnToRecommendView{
    [self setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) ];
}

-(void)turnToLocationView{
    [self setContentOffset: CGPointMake(0, 0)];
}


@end
