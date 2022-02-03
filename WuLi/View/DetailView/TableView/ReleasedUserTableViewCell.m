//
//  ReleasedUserTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "ReleasedUserTableViewCell.h"

@implementation ReleasedUserTableViewCell

- (void)setFrame:(CGRect)frame {

    frame.size.width =[UIScreen mainScreen].bounds.size.width;

    [super setFrame:frame];
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
    self.headImageBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
    [self.headImageBtn.layer setCornerRadius:35.0];
    [self.headImageBtn.layer masksToBounds];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, self.frame.size.width/2-80, 30)];
    self.nameLabel.font=[UIFont systemFontOfSize:18];
    self.nameLabel.textAlignment=NSTextAlignmentLeft;
    
    self.followingBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-65, 5, 60, 30)];
    [self.followingBtn.layer setCornerRadius:15.0];
    [self.followingBtn.layer masksToBounds];
    self.followingBtn.backgroundColor=[UIColor orangeColor];
    [self.followingBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.followingBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.followingBtn addTarget:self action:@selector(followingUser:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.userDesLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, self.frame.size.width-80, 30)];
    self.userDesLabel.font=[UIFont systemFontOfSize:15];
    self.userDesLabel.textAlignment=NSTextAlignmentLeft;
    [self.userDesLabel setTextColor:[UIColor grayColor]];
    
    [self addSubview:self.headImageBtn];
    [self addSubview:self.nameLabel];
    [self.contentView addSubview:self.followingBtn];
    [self addSubview:self.userDesLabel];
}

-(void)layoutWithModel:(CommodityModel *)model{
    
    self.model=model;
    
    NSArray *followingUsers=[UserDefaults getUser].followingUsers;
    if([followingUsers containsObject:model.userId]){
        [self.followingBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.followingBtn setBackgroundColor:[UIColor grayColor]];
    }
    
    
    
    
    self.nameLabel.text=[model valueForKey:@"userName"];
    
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
    [bquery whereKey:@"objectId" equalTo:model.userId];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(array){
            BmobObject *user=array[0];
            NSArray *releaseCommodityArray=[[user objectForKey:@"releasedCommodityIDs"] valueForKey:@"objects"];
            NSArray *fansArray=[[user objectForKey:@"fansUsers"] valueForKey:@"objects"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userDesLabel.text=[NSString stringWithFormat:@"发布 %lu      粉丝 %lu",releaseCommodityArray.count,fansArray.count];
            });
        }
    }];
    
    
    dispatch_queue_t queue=dispatch_queue_create("getUserHeadImage", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        NSURL *url=[NSURL URLWithString:[model valueForKey:@"headImageUrlCompression"]];
        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headImageBtn setBackgroundImage:[image circleImage] forState:UIControlStateNormal];
        });
        
    });
}

-(void)followingUser:(UIButton *)sender{
    if([[UserStatus sharedInstance]getUserStatus]){
        if([[sender currentTitle] isEqualToString:@"关注"]){
            [[UserStatus sharedInstance]followUser:self.model.userId successBlock:^(BOOL isSuccessful) {
                if(isSuccessful){
                    [sender setTitle:@"已关注" forState:UIControlStateNormal];
                    [sender setBackgroundColor:[UIColor grayColor]];
                }
            }];
        }else{
            [[UserStatus sharedInstance]cancleFollowUser:self.model.userId successBlock:^(BOOL isSuccessful) {
                if(isSuccessful){
                    [sender setTitle:@"关注" forState:UIControlStateNormal];
                    [sender setBackgroundColor:[UIColor orangeColor]];
                }
            }];
        }
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotRegisterView" object:nil ];
    }
    
}

@end
