//
//  SetCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/1.
//

#import "SetCollectionViewCell.h"

@implementation SetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.exitLabel=[[UILabel alloc]initWithFrame:self.frame];
    self.exitLabel.textColor=[UIColor redColor];
    self.exitLabel.text=@"退出登录";
    self.exitLabel.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:self.exitLabel];
}

@end
