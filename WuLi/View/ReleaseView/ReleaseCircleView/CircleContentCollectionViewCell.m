//
//  CircleContentCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/24.
//

#import "CircleContentCollectionViewCell.h"

@interface CircleContentCollectionViewCell() <UITextViewDelegate>

@end




@implementation CircleContentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册通知 取消textView的第一响应者
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TextResignFirstResponder) name:@"CircleTextResignFirstResponder" object:nil];
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    
    //初始化textView 设置参数
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.textView.font=[UIFont systemFontOfSize:18];
    [self.textView.layer setCornerRadius:10];
    self.textView.text=@"请在此输入圈子内容";
    self.textView.textColor=[UIColor lightGrayColor];
    //self.textView.returnKeyType=UIReturnKeyDone;
    
    self.textView.delegate=self;
    
    [self addSubview:self.textView];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.textView.text isEqualToString:@"请在此输入圈子内容"]){
        self.textView.text=@"";
        self.textView.textColor=[UIColor blackColor];
    }
}


-(void)TextResignFirstResponder{
    [self.textView resignFirstResponder];
}



#pragma mark -
#pragma mark UITextViewDelegate


///textView 结束编辑时
///将输入的text传给model
- (void)textViewDidEndEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"submitCircleInformation" object:nil userInfo:@{@"circleContent":self.textView.text}];
    
}




@end
