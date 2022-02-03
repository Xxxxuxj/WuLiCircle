//
//  MineView.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "MineView.h"

@implementation MineView

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
    
    self.topView=[[MineTopView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    //self.topView.backgroundColor=[UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUser:) name:@"setUser" object:nil];
    
    UIView *functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 210, self.frame.size.width, 80)];
    
    UIButton *myBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width/3-20, 80)];
    [myBtn setTitle:@"我发布的" forState:UIControlStateNormal];
    [myBtn setBackgroundColor:[UIColor orangeColor]];
    [myBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *starBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3+10, 0, self.frame.size.width/3-20, 80)];
    [starBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    [starBtn setBackgroundColor:[UIColor orangeColor]];
    [starBtn addTarget:self action:@selector(starBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *historyBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/3 * 2+10, 0, self.frame.size.width/3-20, 80)];
    [historyBtn setTitle:@"浏览记录" forState:UIControlStateNormal];
    [historyBtn setBackgroundColor:[UIColor orangeColor]];
    [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [functionView addSubview:myBtn];
    [functionView addSubview:starBtn];
    [functionView addSubview:historyBtn];
    
    
    
    UIView *quanziView=[[UIView alloc]initWithFrame:CGRectMake(10, 300, self.frame.size.width-20, 80)];
    [quanziView.layer setCornerRadius:20];
    quanziView.backgroundColor=[UIColor colorWithRed:220.0/256.0 green:220.0/256.0 blue:220.0/256.0 alpha:1.0];
    
    UIButton *wantBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 60) ];
    [wantBtn setTitle:@"我想要的" forState:UIControlStateNormal];
    [wantBtn setBackgroundColor:[UIColor orangeColor]];
    [wantBtn addTarget:self action:@selector(wantBtnClick) forControlEvents:UIControlEventTouchUpInside];
    wantBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *dealBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-20)/4+10, 10, 60, 60) ];
    [dealBtn setTitle:@"我的交易" forState:UIControlStateNormal];
    [dealBtn setBackgroundColor:[UIColor orangeColor]];
    [dealBtn addTarget:self action:@selector(dealBtnClick) forControlEvents:UIControlEventTouchUpInside];
    dealBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *likeBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-20)/4*2+10, 10, 60, 60) ];
    [likeBtn setTitle:@"我的点赞" forState:UIControlStateNormal];
    [likeBtn setBackgroundColor:[UIColor orangeColor]];
    [likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    likeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *receiveBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width-20)/4*3+10, 10, 60, 60) ];
    [receiveBtn setTitle:@"我收到的" forState:UIControlStateNormal];
    [receiveBtn setBackgroundColor:[UIColor orangeColor]];
    [receiveBtn addTarget:self action:@selector(receiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    receiveBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [quanziView addSubview:wantBtn];
    [quanziView addSubview:dealBtn];
    [quanziView addSubview:likeBtn];
    [quanziView addSubview:receiveBtn];
    
    UIView *setView=[[UIView alloc]initWithFrame:CGRectMake(10, 400, self.frame.size.width-20, 400)];
    [setView.layer setCornerRadius:20];
    setView.backgroundColor=[UIColor colorWithRed:220.0/256.0 green:220.0/256.0 blue:220.0/256.0 alpha:1.0];
    
    UIButton *myHomeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, setView.frame.size.width, 100)];
    [setView addSubview:myHomeBtn];
    [myHomeBtn addTarget:self  action:@selector(myHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myHomeBtn setTitle:@"我的主页" forState:UIControlStateNormal];
    [myHomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
    scrollView.contentSize=CGSizeMake(self.frame.size.width,self.topView.frame.size.height+ functionView.frame.size.height +quanziView.frame.size.height+setView.frame.size.height);
    
    
    [scrollView addSubview:self.topView];
    [scrollView addSubview:functionView];
    [scrollView addSubview:quanziView];
    [scrollView addSubview:setView];
    [self addSubview:scrollView];

}

-(void) layoutWihtLocalData{
    [self.topView layoutWihtLocalData];
}


-(void)setUser:(NSNotification *)notification{
    [self.topView layoutWithUser:[notification.userInfo objectForKey:@"model"]];
    
}

-(void)starBtnClick{
    if([[UserStatus sharedInstance] getUserStatus]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushStarViewController" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushRegisterViewController" object:nil];
    }
}

-(void)historyBtnClick{
    if([[UserStatus sharedInstance] getUserStatus]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushHistoryViewController" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushRegisterViewController" object:nil];
    }
}

-(void)myBtnClick{
    if([[UserStatus sharedInstance] getUserStatus]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushMyIssueViewController" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushRegisterViewController" object:nil];
    }
}

-(void)wantBtnClick{
    
}

-(void)dealBtnClick{
    
}

-(void)likeBtnClick{
    
}

-(void)receiveBtnClick{
    
}

-(void)myHomeBtnClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushUserViewController" object:nil userInfo:@{@"userID":[UserDefaults getUser].userId}];
}

@end
