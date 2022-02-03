//
//  PriceCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/16.
//

#import "PriceCollectionViewCell.h"

@interface PriceCollectionViewCell()<UITextFieldDelegate>


@end


@implementation PriceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册通知 取消textfield 的第一响应者
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PriceResignFirstResponder) name:@"PriceResignFirstResponder" object:nil];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
    //设置cell参数 背景颜色、圆角
    self.backgroundColor=[UIColor whiteColor];
    [self.layer setCornerRadius:10.0];
    
    
    //priceLabel初始化 设置参数
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, self.bounds.size.height)];
    self.priceLabel.textColor=[UIColor grayColor];
    self.priceLabel.text=@"预估价格¥";
    self.priceLabel.font=[UIFont systemFontOfSize:15];
    
    
    //priceTextField初始化 设置参数
    self.priceTextField=[[UITextField alloc]initWithFrame:CGRectMake(80, 0, 40, self.bounds.size.height)];
    self.priceTextField.placeholder=@"价格";
    self.priceTextField.delegate=self;
    self.priceTextField.keyboardType=UIKeyboardTypeNumberPad;
    
    
    [self addSubview:self.priceLabel];
    [self addSubview:self.priceTextField];
}

-(void)PriceResignFirstResponder{
    
    [self.priceTextField resignFirstResponder];
    
    //输入结束后 回调mainScrollView的contentOffset
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pirceInputEnd" object:nil];
}


#pragma mark -
#pragma mark UITextFieldDelegate

//开始输入的时候 发送通知改变mainScrollView的contentOffset
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pirceInput" object:nil];
}


//结束输入的时候 传入输入的数据
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"submitInformation" object:nil userInfo:@{@"price":textField.text}];
}





@end
