//
//  LabelCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/27.
//

#import "LabelCollectionViewCell.h"

@implementation LabelCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.label=[[UILabel alloc]initWithFrame:self.frame];
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.textColor=[UIColor grayColor];
    self.label.backgroundColor=[UIColor blackColor];
    
    [self addSubview:self.label];
}

-(void)layoutWithLabelText:(NSString *)text{
    [self.label setText:text];
}



@end
