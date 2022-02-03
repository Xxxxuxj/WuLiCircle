//
//  CommodityLocationCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/16.
//

#import "CommodityLocationCollectionViewCell.h"

@implementation CommodityLocationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册一个通知 接受locationLabel的text
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setLocation:) name:@"setLocation" object:nil];
        [self setUI];
    }
    return self;
}

-(void)setUI{

    
    //locationLabel初始化 设置参数
    self.locationLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.bounds.size.height)];
    self.locationLabel.backgroundColor=[UIColor whiteColor];
    [self.locationLabel.layer setCornerRadius:10.0];
    [self.locationLabel setText:@"南湖"];
    [self.locationLabel setTextAlignment:NSTextAlignmentCenter];
    
    //当locationLabel的text改变时 得到新的数据
    [self.locationLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.locationLabel];
    
}


//设置地点
-(void)setLocation:(NSNotification *)notification{
    [self.locationLabel setText: [notification.userInfo valueForKey:@"location"]];
}


///当locationLabel的text改变时
///发送通知给model 更新location
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"commodityLocationChanged" object:nil userInfo:@{@"location":self.locationLabel.text}];
}

@end
