//
//  UserReleaseTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "SectionFlowLayout.h"
#import "UserCommodityCollectionViewCell.h"
#import "UserCircleCollectionViewCell.h"
#import "GetUserInformationByUserID.h"
#import "GetCommodityOrCircle.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserReleaseTableViewCell : UITableViewCell

@property (nonatomic) UIScrollView          *scrollView;
@property (nonatomic) UICollectionView      *commodityCollectionView;
@property (nonatomic) UICollectionView      *circleCollectionView;
@property (nonatomic) NSString              *userID;

-(void)layoutWithUserID:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
