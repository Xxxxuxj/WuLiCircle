//
//  RecommandCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "UIImage+CircleImage.h"
#import "GetUserInformationByUserID.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecommendCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView           *imageView;
@property (nonatomic) UILabel               *desLabel;
@property (nonatomic) UILabel               *priceLabel;
@property (nonatomic) UILabel               *localLabel;
@property (nonatomic) UILabel               *fuhaoLabel;
@property (nonatomic) UILabel               *nameLabel;
@property (nonatomic) UIImageView           *headImageView;


-(void)layoutWithModel:(RecommendModel *)model;

@end

NS_ASSUME_NONNULL_END
