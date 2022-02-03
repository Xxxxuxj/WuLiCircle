//
//  CommodityInformationTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommodityInformationTableViewCell : UITableViewCell

@property (nonatomic) UILabel               *desLabel;
@property (nonatomic) UILabel               *detailLabel;
@property (nonatomic) UILabel               *priceLabel;
@property (nonatomic) UILabel               *localLabel;
@property (nonatomic) UILabel               *fuhaoLabel;
@property (nonatomic) UIButton              *moreBtn;
@property (nonatomic) CommodityModel        *model;
@property (nonatomic) BOOL                  *showMore;

-(void)layoutWithModel:(CommodityModel *)model ifshowMore:(BOOL)showMore;

@end

NS_ASSUME_NONNULL_END
