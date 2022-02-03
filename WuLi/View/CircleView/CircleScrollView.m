//
//  CircleScrollView.m
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import "CircleScrollView.h"

@implementation CircleScrollView

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
        self.showsVerticalScrollIndicator=FALSE;
        self.showsHorizontalScrollIndicator=FALSE;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(turnToHomeView) name:@"turnToHomeView" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(turnToFollowingView) name:@"turnToFollowingView" object:nil];
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
    self.homeView=[[HomeView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    CircleModel *model1=[CircleModel new];
    model1.picArray=@[@"1",@"2"];
    
    CircleModel *model2=[CircleModel new];
    model2.picArray=@[@"1",@"2",@"3"];
    
    CircleModel *model3=[CircleModel new];
    model3.picArray=@[@"1"];
    
    CircleModel *model4=[CircleModel new];
    model4.picArray=@[];
    
    
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    
    
    [self.homeView layoutWithModelArray:array];
    
    
    self.followingView=[[FollowingView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.followingView.backgroundColor=[UIColor blueColor];
    
    
    
    [self addSubview:self.homeView];
    [self addSubview:self.followingView];
}


-(void)turnToHomeView{
    self.contentOffset=CGPointMake(0, 0);
}



-(void)turnToFollowingView{
    self.contentOffset=CGPointMake(self.frame.size.width, 0);
}





- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint point=[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    if(point.x <= 0){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"followingPage" object:nil];
    }else if(point.x >= [UIScreen mainScreen].bounds.size.width){ 
        [[NSNotificationCenter defaultCenter]postNotificationName:@"homePage" object:nil];
    }
}





@end
