//
//  UserInformationTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import "UserInformationTableViewCell.h"

@implementation UserInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView=[[UIImageView alloc]initWithFrame:self.frame];
    self.headImageView.backgroundColor=[UIColor greenColor];
    [self addSubview:self.headImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if(self =[super initWithFrame:frame]){
//        self.headImageView=[[UIImageView alloc]initWithFrame:frame];
//        self.headImageView.backgroundColor=[UIColor greenColor];
//        [self addSubview:self.headImageView];
//    }
//    return self;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUI];
    }
    return self;
}


-(void)setUI{
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.headImageView.layer setCornerRadius:40];
    self.headImageView.layer.masksToBounds=YES;
    //self.headImageView.backgroundColor=[UIColor greenColor];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.frame.size.width-120, 30)];
    self.nameLabel.textAlignment=NSTextAlignmentLeft;
    self.nameLabel.backgroundColor=[UIColor redColor];
    
    self.idLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 40, self.frame.size.width-120, 20)];
    self.idLabel.textAlignment=NSTextAlignmentLeft;
    self.idLabel.backgroundColor=[UIColor blueColor];
    
    self.dLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 60, self.frame.size.width-120, 40)];
    self.dLabel.textAlignment=NSTextAlignmentLeft;
    self.dLabel.backgroundColor=[UIColor yellowColor];
    
    self.editBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-20,70, 70, 30)];
    [self.editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.idLabel];
    [self addSubview:self.dLabel];
    [self.contentView addSubview:self.editBtn];
}

-(void)editBtnClick{
    NSLog(@"click");
}

-(void)layoutWithModel:(UserInformationModel *)model{
    self.nameLabel.text=model.userName;
    self.idLabel.text=model.userId;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headImageUrlCompression]];
    self.dLabel.text=model.userSign ? model.userSign:@"该用户太懒了...";
}


@end
