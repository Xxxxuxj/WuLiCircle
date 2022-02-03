//
//  LocationView.h
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import <UIKit/UIKit.h>
#import "LocationCollectionViewCell.h"
#import "GetCommodityOrCircle.h"
#import "UserDefaults.h"
NS_ASSUME_NONNULL_BEGIN

@interface LocationView : UIView

@property (nonatomic) UICollectionView          *collectionView;
@property (nonatomic)NSMutableArray             *recommendArray;
@property (nonatomic)NSMutableArray             *commodityIdArray;

@end

NS_ASSUME_NONNULL_END
