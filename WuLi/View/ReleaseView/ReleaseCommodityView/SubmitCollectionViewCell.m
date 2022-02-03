//
//  SubmitCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/14.
//

#import "SubmitCollectionViewCell.h"

@implementation SubmitCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.submitLabel=[[UILabel alloc]initWithFrame:self.bounds];
    [self.submitLabel setText:@"提交"];
    [self.submitLabel setBackgroundColor:[UIColor blueColor]];
    self.submitLabel.textAlignment=NSTextAlignmentCenter;
    self.submitLabel.textColor=[UIColor whiteColor];
    
    //[self.submitBtn addTarget:self action:@selector(submitCommodityInformation) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.submitLabel];
}






@end
