//
//  LabelScrollView.m
//  WuLi
//
//  Created by Mac on 2021/12/27.
//

#import "LabelScrollView.h"







@implementation LabelScrollView

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeScrollViewChanged:) name:@"homeScrollViewChanged" object:nil];
    
    
    self.labelTextArray     =[[NSMutableArray alloc]initWithObjects:@"首页",@"失物招领",@"互帮互助",@"资料文件",@"校园信息",@"吃瓜群众",@"寻物启事",@"组织活动",@"信息资讯",@"社团组织", nil];
    
    self.labelBtnArray      =[[NSMutableArray alloc]initWithObjects:_labelBtn1,_labelBtn2,_labelBtn3,_labelBtn4,_labelBtn5,_labelBtn6,_labelBtn7,_labelBtn8,_labelBtn9,_labelBtn10, nil];
    
    
    for(int i=0;i<10;i++){
        self.labelBtnArray[i]=[[UIButton alloc]initWithFrame:CGRectMake(i*60, 0, 60, 30)];
        UIButton *btn=self.labelBtnArray[i];
        [self.labelBtnArray[i] setTitle:self.labelTextArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:10];
        if(i==0){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
            NSString *clickTitle=[NSString stringWithFormat:@"%@°",self.labelTextArray[i]];
            [self.labelBtnArray[i] setTitle: clickTitle forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.labelBtnArray[i]];
        
    }
    
    self.currentBtnIndex=0;
    
    self.indexLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 28, 60, 2)];
    self.indexLabel.backgroundColor=[UIColor blackColor];
    [self addSubview:self.indexLabel];
    
    self.contentSize=CGSizeMake(600, 30);
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=NO;
    
    
    
    
}

-(void)btnClick:(UIButton *)sender{
    NSInteger clickIndex= [self.labelBtnArray indexOfObject:sender];
    [self turnToBtn:clickIndex];
    NSString *index=[NSString stringWithFormat:@"%d",(int)clickIndex];
    
    
    [self.indexLabel setFrame:CGRectMake(sender.frame.origin.x, 28, 60, 2)];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"setHomeViewContentOffset" object:nil userInfo:@{@"index":index}];
    
    
}


-(void)turnToBtn:(NSInteger )newBtnIndex{
    if(newBtnIndex == _currentBtnIndex){
        
    }else{
        UIButton *newBtn=self.labelBtnArray[newBtnIndex];
        [newBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        newBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
        NSString *clickTitle=[NSString stringWithFormat:@"%@°",self.labelTextArray[newBtnIndex]];
        [newBtn setTitle: clickTitle forState:UIControlStateNormal];
        
        UIButton *oldBtn=self.labelBtnArray[_currentBtnIndex];
        [oldBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        oldBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        [oldBtn setTitle:self.labelTextArray[_currentBtnIndex] forState:UIControlStateNormal];
        
        _currentBtnIndex=newBtnIndex;
        
        
    }
}


-(void)homeScrollViewChanged:(NSNotification *)notification{
    CGPoint offset=[[notification.userInfo valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    
    int index=(offset.x+self.bounds.size.width/2)/self.bounds.size.width;
    
    CGFloat lableOriginX=(offset.x/[UIScreen mainScreen].bounds.size.width)*60;
    [self.indexLabel setFrame:CGRectMake(lableOriginX, 28, 60, 2)];
    
    
    
    
    
    if(index != _currentBtnIndex){
        [self turnToBtn:index];
        
        
        //经典计算
        int num=self.bounds.size.width/60;
        if( (index+1)*60 -self.contentOffset.x > self.bounds.size.width){
            [self setContentOffset:CGPointMake( (index+1-num)*60, 0)];
        }else if( (index+1)*60 -self.contentOffset.x <=0 ){
            [self setContentOffset:CGPointMake( (index)*60, 0)];
        }
        
        
    }
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        if((self.currentBtnIndex+1)*60 > self.bounds.size.width){
            int num=self.bounds.size.width/60;
            [self setContentOffset:CGPointMake(_currentBtnIndex-num, 0)];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




@end
