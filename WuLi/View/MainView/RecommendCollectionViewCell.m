//
//  RecommandCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import "RecommendCollectionViewCell.h"

@implementation RecommendCollectionViewCell

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
    
    //self.backgroundColor=[UIColor redColor];
    
    //self.imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageView=[[UIImageView alloc]init];
    
    //self.imageView.backgroundColor=[UIColor blackColor];
    self.imageView.contentMode=UIViewContentModeScaleToFill;
    
    
    self.desLabel=[[UILabel alloc]init];
    self.desLabel.frame=CGRectMake(0, Height-60, Width, 40);
    self.desLabel.numberOfLines=2;
    self.desLabel.font=[UIFont systemFontOfSize:13];
    //self.desLabel.backgroundColor=[UIColor whiteColor];
    [self.desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    
    self.priceLabel=[[UILabel alloc]init];
    self.priceLabel.frame=CGRectMake(15, Height-20, Width/2 - 15, 20);
    self.priceLabel.font=[UIFont systemFontOfSize:20];
    
    
    self.localLabel=[[UILabel alloc]init];
    self.localLabel.frame=CGRectMake(Width/2, Height-7, Width/2-22, 7);
    self.localLabel.textAlignment=NSTextAlignmentRight;
    self.localLabel.font=[UIFont systemFontOfSize:7];
    [self.localLabel setTextColor:[UIColor grayColor]];
    
    self.fuhaoLabel=[[UILabel alloc]init];
    self.fuhaoLabel.frame=CGRectMake(5, Height-13, 10, 10);
    self.fuhaoLabel.text=@"¥";
    self.fuhaoLabel.font=[UIFont systemFontOfSize:15];
    
    self.nameLabel=[[UILabel alloc]init];
    self.nameLabel.frame=CGRectMake(Width/2, Height-22, Width/2-22, 15);
    self.nameLabel.textAlignment=NSTextAlignmentRight;
    self.nameLabel.font=[UIFont systemFontOfSize:10];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    [self.nameLabel setTextColor:[UIColor grayColor]];
    
    
    self.headImageView=[[UIImageView alloc]init];
    self.headImageView.frame=CGRectMake(Width-20, Height-20, 20, 20);
    [self.headImageView.layer setCornerRadius:10.0];
    self.headImageView.layer.masksToBounds=YES;
    
    [self addSubview:self.imageView];
    [self addSubview:self.desLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.localLabel];
    [self addSubview:self.fuhaoLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.headImageView];
}

-(void)layoutWithModel:(RecommendModel *)model{
    
//    __block UIImage *showImage=nil;
//    __block UIImage *headImage=nil;
    //异步获取图片
    //回到主线程更新UI
    
    dispatch_queue_t  queue=dispatch_queue_create("recommend", NULL);
    
    dispatch_async(queue, ^{
        NSURL *url1=[NSURL URLWithString:[model valueForKey:@"firstPicUrl-C"]];
        //showImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:url1]];
        
        NSURL *url2=nil;
        if([model valueForKey:@"headImageUrl-C"]){
            url2=[NSURL URLWithString:[model valueForKey:@"headImageUrl-C"]];
        }else {
            url2=[NSURL URLWithString:[model valueForKey:@"headImageUrl"]];
        }
        //headImage=[[UIImage imageWithData:[NSData dataWithContentsOfURL:url2]] circleImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.imageView setImage:showImage];
            [self.imageView sd_setImageWithURL:url1];
            //[self.headImageView setImage:headImage];
            
            [self.headImageView sd_setImageWithURL:url2];
        });
    });
    
    
//    NSURL *url=[NSURL URLWithString:[[model valueForKey:@"picArray"] firstObject]];
//    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//    self.imageView.image=image;
    self.imageView.frame=CGRectMake(0, 0, self.frame.size.width,self.desLabel.frame.origin.y );
    self.imageView.layer.cornerRadius=10.0;
    self.imageView.layer.masksToBounds=YES;
    
    self.desLabel.text=[model valueForKey:@"title"];
    
    self.priceLabel.text=[model valueForKey:@"price"];;
    
    self.nameLabel.text=[model valueForKey:@"username"];;;
    

    
    self.localLabel.text=[NSString stringWithFormat:@"发布于%@",[model valueForKey:@"location"]];
    
}
@end
