//
//  ImageScrollTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "ImageScrollTableViewCell.h"
@interface ImageScrollTableViewCell()
{
    int picCount;
}
@end

@implementation ImageScrollTableViewCell
- (void)setFrame:(CGRect)frame {

    frame.size.width =[UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    [self layoutWithImgCount:self.picArray.count IamgeArray:self.picArray];
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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pageChanged:) name:@"changePage" object:nil];
        self.imgView=[[ImageScrollView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.imgView];
        self.pageView=[[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width-80, self.bounds.size.height-50, 50, 20)];
        self.pageView.backgroundColor=[UIColor blackColor];
        self.pageView.alpha=0.6;
        [self.pageView.layer setCornerRadius:10];
        
        self.pageLabel=[[UILabel alloc]initWithFrame:self.pageView.bounds];
        self.pageLabel.textAlignment=NSTextAlignmentCenter;
        self.pageLabel.textColor=[UIColor whiteColor];
        [self.pageView addSubview:self.pageLabel];
        [self addSubview:self.pageView];
    }
    return self;
}


- (void)layoutWithImgCount:(NSInteger )count IamgeArray:(NSArray *)array{
    self.picArray=array;
    [self.imgView setFrame:self.bounds];
    [self.imgView layoutWithIamgeArray:array];
    
    
    [self.pageView setFrame:CGRectMake(self.bounds.size.width-80, self.bounds.size.height-50, 50, 20)];
    
    [self.pageLabel setFrame:self.pageView.bounds];
    self.pageLabel.text=[NSString stringWithFormat:@"1/%d",(int)count];

    
    picCount=(int)count;
    
}

-(void)pageChanged:(NSNotification *)notification{
    CGPoint offset=[[[notification.userInfo objectForKey:@"change"] objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    int num=(offset.x+self.frame.size.width/2)/self.frame.size.width;
 
    self.pageLabel.text=[NSString stringWithFormat:@"%d/%d",num+1,picCount];
}


@end
