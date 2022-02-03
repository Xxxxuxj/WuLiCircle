//
//  CircleLabelCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/24.
//

#import "CircleLabelCollectionViewCell.h"

@implementation CircleLabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.ifSelected=NO;
    
    self.labelBtn=[[UIButton alloc]initWithFrame:self.bounds];
    [self.labelBtn setBackgroundImage:[UIImage imageNamed:@"circleLabel_normal"] forState:UIControlStateNormal];

    self.labelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.labelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.labelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.labelBtn addTarget:self action:@selector(labelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.labelBtn.layer setCornerRadius:10.0];
    self.labelBtn.layer.masksToBounds=YES;
    self.labelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    [self addSubview:self.labelBtn];
}




-(void)setLabelText:(NSString *)text{
    [self.labelBtn setTitle:text forState:UIControlStateNormal];
}


-(void)labelBtnClick{
    
    NSLog(@"click");
    
    
    if(!self.ifSelected){
        self.ifSelected=YES;
        [self.labelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelBtn setBackgroundImage:[UIImage imageNamed:@"circleLabel_highlighted"] forState:UIControlStateNormal];
    }else{
        self.ifSelected=NO;
        [self.labelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.labelBtn setBackgroundImage:[UIImage imageNamed:@"circleLabel_normal"] forState:UIControlStateNormal];
    }
    
    
}


@end
