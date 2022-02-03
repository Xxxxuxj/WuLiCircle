//
//  HomeCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _headBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_headBtn.layer setCornerRadius:15];
    _headBtn.backgroundColor=[UIColor redColor];
    
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, self.frame.size.width/2 -35, 30)];
    _nameLabel.backgroundColor=[UIColor yellowColor];
    
    
    _functionBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 20, 0, 20, 20)];
    _functionBtn.backgroundColor=[UIColor blueColor];
    
    
    _contextLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 50)];
    _contextLabel.backgroundColor=[UIColor redColor];
    
    _forwardBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50, self.frame.size.height-30, 50, 30)];
    _forwardBtn.backgroundColor=[UIColor yellowColor];
    
    _commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-30, 50, 30)];
    _commentBtn.backgroundColor=[UIColor blueColor];
    
    _likebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-150, self.frame.size.height-30, 50, 30)];
    _likebtn.backgroundColor=[UIColor redColor];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width-150, 30)];
    _timeLabel.backgroundColor=[UIColor yellowColor];
    
    
    [self addSubview:_headBtn];
    [self addSubview:_nameLabel];
    [self addSubview:_contextLabel];
    [self addSubview:_forwardBtn];
    [self addSubview:_commentBtn];
    [self addSubview:_likebtn];
    [self addSubview:_timeLabel];
    [self addSubview:_functionBtn];
}

- (void)layoutWithCircleModel:(CircleModel *)model{
    
    
    if(model.picArray.count >=1){
        int count = 3 >= model.picArray.count ? (int)model.picArray.count:3;
        CGFloat spacing=(self.frame.size.width-240)/4;
        for(int i=0;i<count;i++){
            CGFloat x=i*80+(i+1)*spacing;
            UIImageView* imgView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 100, 80, 80)];
            imgView.backgroundColor=[UIColor blueColor];
            [self addSubview:imgView];
        }
    }
    
    
    
    
}


@end
