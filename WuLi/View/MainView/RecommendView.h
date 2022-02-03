//
//  RecommandView.h
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import <UIKit/UIKit.h>
#import "RoundView.h"
#import "RecommendCollectionViewCell.h"
#import "RoundCollectionViewCell.h"
#import "SectionFlowLayout.h"
#import "RecommendModel.h"
#import "CommodityModel.h"
#import "GetCommodityOrCircle.h"
#import "UserDefaults.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendView : UIView
@property (nonatomic,strong) UICollectionView           *commodityCollectionView;
@property (nonatomic,strong) RoundView                  *roundView;
@property (nonatomic)NSMutableArray                     *roundImageArray;
@property (nonatomic)NSMutableArray                     *recommendArray;
@property (nonatomic)NSMutableArray                     *commodityIdArray;
@property (nonatomic)NSMutableArray                     *commodityHeightArray;
@end

NS_ASSUME_NONNULL_END
