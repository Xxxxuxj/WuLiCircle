//
//  CircleTitleCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/24.
//

#import "CircleTitleCollectionViewCell.h"

@interface CircleTitleCollectionViewCell() <UITextViewDelegate>

@end




@implementation CircleTitleCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册通知 取消textView的第一响应者
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TitleResignFirstResponder) name:@"CircleTitleResignFirstResponder" object:nil];
        [self setUI];
    }
    return self;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TitleResignFirstResponder" object:nil];
}



-(void)setUI{
    
    //初始化titleTextView 并设置
    self.titleTextView=[[UITextView alloc]initWithFrame:self.bounds];
    [self.titleTextView.layer setCornerRadius:10.0];
    self.titleTextView.textColor=[UIColor blackColor];
    self.titleTextView.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    self.titleTextView.delegate=self;
    
    [self addSubview:self.titleTextView];
}


-(void)TitleResignFirstResponder{
    [self.titleTextView resignFirstResponder];
}

#pragma mark -
#pragma mark UITextViewDelegate


///textView 结束编辑时
///将输入的text传给model
- (void)textViewDidEndEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"submitCircleInformation" object:nil userInfo:@{@"circleTitle":self.titleTextView.text}];
}


@end
