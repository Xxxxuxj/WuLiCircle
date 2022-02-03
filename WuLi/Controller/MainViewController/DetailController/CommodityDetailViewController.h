//
//  CommodityDetailViewController.h
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import <UIKit/UIKit.h>
#import "CommodityView.h"
#import "CommodityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommodityDetailViewController : UIViewController

@property (nonatomic) CommodityView             *detailView;
@property (nonatomic) CommodityModel            *model;

-(instancetype)initWithModel:(CommodityModel *)model;
@end

NS_ASSUME_NONNULL_END
