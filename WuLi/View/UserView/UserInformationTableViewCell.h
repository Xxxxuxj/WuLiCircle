//
//  UserInformationTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "UserInformationModel.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInformationTableViewCell : UITableViewCell

@property(nonatomic) UIImageView    *headImageView;
@property(nonatomic) UILabel        *nameLabel;
@property(nonatomic) UILabel        *idLabel;
@property(nonatomic) UILabel        *dLabel;
@property(nonatomic) UIButton       *editBtn;


-(void)layoutWithModel:(UserInformationModel *)model;

@end

NS_ASSUME_NONNULL_END
