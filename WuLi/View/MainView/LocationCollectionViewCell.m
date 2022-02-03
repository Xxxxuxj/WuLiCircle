//
//  LocationCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import "LocationCollectionViewCell.h"

@implementation LocationCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGFloat Width=self.frame.size.width;
    CGFloat Height=self.frame.size.height;
    CGFloat btnHeight=30;
    CGFloat btnWidth=Width/3;
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, Height-btnHeight, btnWidth, btnHeight)];
    self.leftBtn.backgroundColor=[UIColor redColor];
    [self.leftBtn setTitle:@"点赞" forState:UIControlStateNormal];
    
    
    self.midBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnWidth, Height-btnHeight, btnWidth, btnHeight)];
    self.midBtn.backgroundColor=[UIColor yellowColor];
    [self.midBtn setTitle:@"评论" forState:UIControlStateNormal];
    
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnWidth*2, Height-btnHeight, btnWidth, btnHeight)];
    self.rightBtn.backgroundColor=[UIColor blueColor];
    [self.rightBtn setTitle:@"私聊" forState:UIControlStateNormal];
    
    
    CGFloat headHeight=30;
    CGFloat headWidth=30;
    self.userHeadBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, headWidth, headHeight)];
    //self.userHeadBtn.backgroundColor=[UIColor blueColor];
    
    
    CGFloat nameWidth=Width/2-headWidth;
    CGFloat nameHeight=headHeight;
    self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(headWidth,0, nameWidth, nameHeight)];
    self.userNameLabel.textAlignment=NSTextAlignmentLeft;
    
    
    CGFloat timeWidth=Width/2;
    CGFloat timeHeight=headHeight;
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width/2,0, timeWidth, timeHeight)];
    self.timeLabel.textAlignment=NSTextAlignmentRight;
    
    
    
    [self addSubview:_userHeadBtn];
    [self addSubview:_leftBtn];
    [self addSubview:_midBtn];
    [self addSubview:_rightBtn];
    [self addSubview:_userNameLabel];
    [self addSubview:_timeLabel];
}


-(void)layoutWithModel:(RecommendModel *)model{
    self.userNameLabel.text=[model valueForKey:@"username"];
    NSArray *picArray=[model valueForKey:@"picArray"];
    NSString *queueName=[NSString stringWithFormat:@"%@",[model valueForKey:@"objectId"]];
    const char *cString = [queueName UTF8String];
    dispatch_queue_t queue=dispatch_queue_create(cString, NULL);
    dispatch_async(queue, ^{
        
        NSURL *url=[NSURL URLWithString:[model valueForKey:@"headImageUrl-C"]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userHeadBtn setBackgroundImage:[image circleImage] forState:UIControlStateNormal];
        });
        
        
        
    });
    for(int i=0;i<picArray.count;i++){
        //UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20+i*100, 40, 80, 80)];
        NSURL *url=[NSURL URLWithString:picArray[i]];
//        NSData *data=[NSData dataWithContentsOfURL:url];
//
//        UIImage *pImage=[UIImage imageWithData:data];
//        NSData *cData=[pImage compressQualityWithMaxLength:1];
//        UIImage *preImage=[UIImage imageWithData:cData];
        //imageView.image=preImage;
        //dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20+i*120, 40, 100, 100)];
            [imageView sd_setImageWithURL:url] ;
            [self addSubview:imageView];
        //});
    }
}



@end
