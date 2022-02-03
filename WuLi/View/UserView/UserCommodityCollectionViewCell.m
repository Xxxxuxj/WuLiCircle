//
//  UserCommodityCollectionViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import "UserCommodityCollectionViewCell.h"

@implementation UserCommodityCollectionViewCell
/*
 @property (nonatomic) UIImageView           *imageView;
 @property (nonatomic) UILabel               *desLabel;
 @property (nonatomic) UILabel               *priceLabel;
 @property (nonatomic) UILabel               *fuhaoLabel;
 @property (nonatomic) UIButton              *setBtn;
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setUI];
    }
    return self;
}

-(void)layoutWithBmobObject:(BmobObject *)bmob{
    self.bmobObject=bmob;
    [self setUI];
}


-(void)setUI{
    CGFloat Width=self.frame.size.width;
    CGFloat Height=self.frame.size.height;
    
    //self.backgroundColor=[UIColor redColor];
    
    //self.imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-60)];
    //self.imageView.backgroundColor=[UIColor blackColor];
    self.imageView.contentMode=UIViewContentModeScaleToFill;
    [self.imageView.layer setCornerRadius:10.0];
    self.imageView.layer.masksToBounds=YES;
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *image = [imageCache imageFromDiskCacheForKey:[self.bmobObject objectForKey:@"firstPicUrl-C"]];
    self.imageView.image=image;
    
    self.desLabel=[[UILabel alloc]init];
    self.desLabel.frame=CGRectMake(0, Height-60, Width, 40);
    self.desLabel.numberOfLines=2;
    self.desLabel.font=[UIFont systemFontOfSize:13];
    //self.desLabel.backgroundColor=[UIColor whiteColor];
    [self.desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    self.desLabel.text=[self.bmobObject objectForKey:@"title"];
    
    self.priceLabel=[[UILabel alloc]init];
    self.priceLabel.frame=CGRectMake(15, Height-20, Width/2 - 15, 20);
    self.priceLabel.font=[UIFont systemFontOfSize:20];
    self.priceLabel.text=[self.bmobObject objectForKey:@"price"];
    
    
    self.fuhaoLabel=[[UILabel alloc]init];
    self.fuhaoLabel.frame=CGRectMake(5, Height-13, 10, 10);
    self.fuhaoLabel.text=@"¥";
    self.fuhaoLabel.font=[UIFont systemFontOfSize:15];
     
    [self addSubview:self.imageView];
    [self addSubview:self.desLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.fuhaoLabel];
}




@end
