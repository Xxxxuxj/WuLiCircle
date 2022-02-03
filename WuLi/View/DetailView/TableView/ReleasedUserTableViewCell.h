//
//  ReleasedUserTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
#import "UIImage+CircleImage.h"
#import "GetUserInformationByUserID.h"
#import "UserStatus.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleasedUserTableViewCell : UITableViewCell
@property (nonatomic) UILabel               *nameLabel;
@property (nonatomic) UIButton              *headImageBtn;
@property (nonatomic) UIButton              *followingBtn;
@property (nonatomic) UILabel               *userDesLabel;
@property (nonatomic) CommodityModel        *model;

-(void)layoutWithModel:(CommodityModel *)model;
@end

NS_ASSUME_NONNULL_END
