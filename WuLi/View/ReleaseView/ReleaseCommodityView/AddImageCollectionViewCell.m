//
//  AddImageCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/14.
//

#import "AddImageCollectionViewCell.h"

@implementation AddImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    //初始化imgBtn 设置参数
    self.imgBtn=[[UIButton alloc]initWithFrame:self.bounds];
    self.imgBtn.titleLabel.font=[UIFont systemFontOfSize:40];
    [self.imgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.imgBtn setUserInteractionEnabled:NO];
    [self addSubview:self.imgBtn];
    
}




-(void)layoutWithImage:(UIImage *)img index:(NSInteger)index{
    
    //使index传给self.index
    self.index=index;
    
    //设置imgBtn的backgroundImage
    [self.imgBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    //如果图片不是添加图片的图片
    if(index>=0){
        
        //添加一个deleteBtn 删除图片
        self.deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-20, 0, 20, 20)];
        [self.deleteBtn setTitle:@"X" forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.deleteBtn.alpha=0.5;
        [self addSubview:self.deleteBtn];
    }
    
    
}

///删除图片 发送通知给imgCollectionview 删除的图片的下标为index
///更新数据
-(void)deleteImage{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteAddedImage" object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%lu",self.index]}];
    [self.deleteBtn removeFromSuperview];
}



@end
