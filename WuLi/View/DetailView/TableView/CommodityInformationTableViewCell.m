//
//  CommodityInformationTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "CommodityInformationTableViewCell.h"
static CGSize desSize;
static CGSize detailSize;

@implementation CommodityInformationTableViewCell
- (void)setFrame:(CGRect)frame {

    frame.size.width =[UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    [self reloadFrame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUI];
    }
    return self;
}


-(void)setUI{
    self.desLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-10, 50)];
    self.desLabel.numberOfLines=0;
    [self.desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    self.fuhaoLabel=[[UILabel alloc]init];
    self.fuhaoLabel.frame=CGRectMake(5, self.bounds.size.height-18, 10, 10);
    self.fuhaoLabel.text=@"¥";
    [self.fuhaoLabel setTextColor:[UIColor redColor]];
    self.fuhaoLabel.font=[UIFont systemFontOfSize:15];
    
    self.priceLabel=[[UILabel alloc]init];
    self.priceLabel.frame=CGRectMake(15, self.bounds.size.height-25, self.frame.size.width/2-10, 20);
    [self.priceLabel setTextColor:[UIColor redColor]];
    self.priceLabel.font=[UIFont systemFontOfSize:21];
    self.priceLabel.textAlignment=NSTextAlignmentLeft;
    
    self.localLabel=[[UILabel alloc]init];
    self.localLabel.frame=CGRectMake(self.frame.size.width/2, self.bounds.size.height-17, self.frame.size.width/2-5, 15);
    [self.localLabel setTextColor:[UIColor grayColor]];
    self.localLabel.textAlignment=NSTextAlignmentRight;
    self.localLabel.font=[UIFont systemFontOfSize:14];
    
    self.moreBtn=[[UIButton alloc]init];
    self.moreBtn.frame=CGRectMake(self.frame.size.width-60, self.frame.size.height-30, 55, 15);
    self.moreBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [self.moreBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailLabel=[[UILabel alloc]init];
    [self.detailLabel setTextColor:[UIColor blackColor]];
    self.detailLabel.textAlignment=NSTextAlignmentLeft;
    self.detailLabel.numberOfLines=0;
    
    [self addSubview:self.desLabel];
    [self addSubview:self.fuhaoLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.localLabel];
    [self.contentView addSubview:self.moreBtn];
}

-(void)reloadFrame{
    [self.desLabel setFrame:CGRectMake(5, 0, self.frame.size.width-10, 50)];
//    self.desLabel.numberOfLines=0;
//    [self.desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
//
//    self.fuhaoLabel=[[UILabel alloc]init];
    self.fuhaoLabel.frame=CGRectMake(5, self.bounds.size.height-18, 10, 10);
//    self.fuhaoLabel.text=@"¥";
//    [self.fuhaoLabel setTextColor:[UIColor redColor]];
//    self.fuhaoLabel.font=[UIFont systemFontOfSize:15];
//
//    self.priceLabel=[[UILabel alloc]init];
    self.priceLabel.frame=CGRectMake(15, self.bounds.size.height-25, self.frame.size.width/2-10, 20);
//    [self.priceLabel setTextColor:[UIColor redColor]];
//    self.priceLabel.font=[UIFont systemFontOfSize:21];
//    self.priceLabel.textAlignment=NSTextAlignmentLeft;
//
//    self.localLabel=[[UILabel alloc]init];
    self.localLabel.frame=CGRectMake(self.frame.size.width/2, self.bounds.size.height-17, self.frame.size.width/2-5, 15);
//    [self.localLabel setTextColor:[UIColor grayColor]];
//    self.localLabel.textAlignment=NSTextAlignmentRight;
//    self.localLabel.font=[UIFont systemFontOfSize:14];
//
//    self.moreBtn=[[UIButton alloc]init];
    self.moreBtn.frame=CGRectMake(self.frame.size.width-60, self.frame.size.height-30, 55, 15);
//    self.moreBtn.titleLabel.font=[UIFont systemFontOfSize:13];
//    [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//    [self.moreBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//    [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.detailLabel=[[UILabel alloc]init];
//    [self.detailLabel setTextColor:[UIColor blackColor]];
//    self.detailLabel.textAlignment=NSTextAlignmentLeft;
//    self.detailLabel.numberOfLines=0;
//
//    [self addSubview:self.desLabel];
//    [self addSubview:self.fuhaoLabel];
//    [self addSubview:self.priceLabel];
//    [self addSubview:self.localLabel];
//    [self addSubview:self.moreBtn];
    
    self.desLabel.text=[_model valueForKey:@"commodityTitle"];
    self.priceLabel.text=[_model valueForKey:@"price"];
    self.localLabel.text=[_model valueForKey:@"location"];
    self.detailLabel.text=[_model valueForKey:@"commodityDescription"];
    
    if(_showMore){
        [self.desLabel setFrame:CGRectMake(5, 0, desSize.width, desSize.height)];
        [self.detailLabel setFrame:CGRectMake(5, desSize.height, detailSize.width, detailSize.height)];
        //self.detailLabel.backgroundColor=[UIColor redColor];
        [self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
        [self addSubview:self.detailLabel];
    }
}

-(void)layoutWithModel:(CommodityModel *)model ifshowMore:(BOOL)showMore{
    _model=model;
    _showMore=showMore;
//    [self.desLabel setFrame:CGRectMake(5, 0, self.frame.size.width-10, 50)];
//    self.desLabel.numberOfLines=0;
//    [self.desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
//
//    self.fuhaoLabel=[[UILabel alloc]init];
//    self.fuhaoLabel.frame=CGRectMake(5, self.bounds.size.height-18, 10, 10);
//    self.fuhaoLabel.text=@"¥";
//    [self.fuhaoLabel setTextColor:[UIColor redColor]];
//    self.fuhaoLabel.font=[UIFont systemFontOfSize:15];
//
//    self.priceLabel=[[UILabel alloc]init];
//    self.priceLabel.frame=CGRectMake(15, self.bounds.size.height-25, self.frame.size.width/2-10, 20);
//    [self.priceLabel setTextColor:[UIColor redColor]];
//    self.priceLabel.font=[UIFont systemFontOfSize:21];
//    self.priceLabel.textAlignment=NSTextAlignmentLeft;
//
//    self.localLabel=[[UILabel alloc]init];
//   self.localLabel.frame=CGRectMake(self.frame.size.width/2, self.bounds.size.height-17, self.frame.size.width/2-5, 15);
//    [self.localLabel setTextColor:[UIColor grayColor]];
//    self.localLabel.textAlignment=NSTextAlignmentRight;
//    self.localLabel.font=[UIFont systemFontOfSize:14];
//
//    self.moreBtn=[[UIButton alloc]init];
//    self.moreBtn.frame=CGRectMake(self.frame.size.width-60, self.frame.size.height-30, 55, 15);
//    self.moreBtn.titleLabel.font=[UIFont systemFontOfSize:13];
//    [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//    [self.moreBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//    [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.detailLabel=[[UILabel alloc]init];
//    [self.detailLabel setTextColor:[UIColor blackColor]];
//    self.detailLabel.textAlignment=NSTextAlignmentLeft;
//    self.detailLabel.numberOfLines=0;
//
//    [self addSubview:self.desLabel];
//    [self addSubview:self.fuhaoLabel];
//    [self addSubview:self.priceLabel];
//    [self addSubview:self.localLabel];
//    [self addSubview:self.moreBtn];
    
//    self.desLabel.text=[model valueForKey:@"commodityTitle"];
//    self.priceLabel.text=[model valueForKey:@"price"];
//    self.localLabel.text=[model valueForKey:@"location"];
//    self.detailLabel.text=[model valueForKey:@"commodityDescription"];
//
//    if(showMore){
//        [self.desLabel setFrame:CGRectMake(5, 0, desSize.width, desSize.height)];
//        [self.detailLabel setFrame:CGRectMake(5, desSize.height, detailSize.width, detailSize.height)];
//        //self.detailLabel.backgroundColor=[UIColor redColor];
//        [self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
//        [self addSubview:self.detailLabel];
//    }
}

-(void)moreBtnClick:(UIButton *)sender{
    if([sender.titleLabel.text isEqualToString:@"查看更多"]){
        sender.titleLabel.text=@"收起";
        desSize=[self.desLabel sizeThatFits:CGSizeMake(self.desLabel.bounds.size.width, CGFLOAT_MAX)];
        detailSize=[self.detailLabel sizeThatFits:CGSizeMake(self.desLabel.bounds.size.width, CGFLOAT_MAX)];
        
        CGFloat addHeight=desSize.height-50+detailSize.height;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showMore" object:nil userInfo:@{@"addHeight":[NSString stringWithFormat:@"%lf",addHeight] }];
    }
    else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"closeShowMore" object:nil];
    }
    
    
}

@end
