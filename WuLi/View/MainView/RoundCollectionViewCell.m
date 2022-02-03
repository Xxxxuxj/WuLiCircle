//
//  RoundCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import "RoundCollectionViewCell.h"

@implementation RoundCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)layoutWithImageArray:(NSMutableArray *)array{
    self.roundView=[[RoundView alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-10, self.frame.size.height) imgArray:array];
    [self addSubview:self.roundView];
}

@end
