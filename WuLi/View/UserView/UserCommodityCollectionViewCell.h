//
//  UserCommodityCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import <BmobSDk/Bmob.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserCommodityCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView           *imageView;
@property (nonatomic) UILabel               *desLabel;
@property (nonatomic) UILabel               *priceLabel;
@property (nonatomic) UILabel               *fuhaoLabel;
@property (nonatomic) UIButton              *setBtn;
@property (nonatomic) BmobObject            *bmobObject;

-(void)layoutWithBmobObject:(BmobObject *)bmob;

@end

NS_ASSUME_NONNULL_END
