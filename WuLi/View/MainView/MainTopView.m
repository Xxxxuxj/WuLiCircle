//
//  MainTopView.m
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import "MainTopView.h"

@implementation MainTopView

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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"recommendPage" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"locationPage" object:nil];
}


-(void)setUI{
//    self.backgroundColor=[UIColor blueColor];
    CGFloat Width=self.frame.size.width;
    //CGFloat Height=self.frame.size.height;
    self.recommendBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/2, 44, 100, 50)];
    [self.recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.recommendBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [self.recommendBtn addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.locationBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/2-100, 44, 100, 50)];
    [self.locationBtn setTitle:@"南湖" forState:UIControlStateNormal];
    [self.locationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width-60, 100, 50, 30)];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.searchBtn.backgroundColor=[UIColor blueColor];
    [self.searchBtn.layer setMasksToBounds:YES];
    [self.searchBtn.layer setCornerRadius:15.0];
    [self.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.searchText=[[UIButton alloc]initWithFrame:CGRectMake(10, 100, Width-80, 30)];
    //self.searchField.backgroundColor=[UIColor lightGrayColor];
    [self.searchText.layer setMasksToBounds:YES];
    [self.searchText.layer setCornerRadius:15.0];
    [self.searchText.layer setBorderWidth:1.0];
    self.searchText.layer.borderColor=[UIColor blackColor].CGColor;
    [self.searchText addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recommend) name:@"recommendPage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(location) name:@"locationPage" object:nil];
    
    
    
    [self addSubview:self.recommendBtn];
    [self addSubview:self.locationBtn];
    [self addSubview:self.searchText];
    [self addSubview:self.searchBtn];
    
}

-(void)recommendBtnClick:(UIButton *)sender{
//    [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.recommendBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
//
//    [self.locationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    self.locationBtn.titleLabel.font=[UIFont systemFontOfSize:18 ];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"turnToRecommendView" object:nil];
    
}

-(void)locationBtnClick:(UIButton *)sender{
//    [self.recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    self.recommendBtn.titleLabel.font=[UIFont systemFontOfSize:18 ];
//
//    [self.locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.locationBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"turnToLocationView" object:nil];
}

-(void)searchBtnClick:(UIButton *)sender{
    
}


-(void)search:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"searchControllerPushed" object:nil];
}


-(void)recommend{
    [self.recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.recommendBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    
    [self.locationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.locationBtn.titleLabel.font=[UIFont systemFontOfSize:18 ];
}

-(void)location{
    [self.recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.recommendBtn.titleLabel.font=[UIFont systemFontOfSize:18 ];
    
    [self.locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.locationBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
}

@end
