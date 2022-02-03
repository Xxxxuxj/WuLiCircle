//
//  PriceCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceCollectionViewCell : UICollectionViewCell


//价格label
@property (nonatomic) UILabel            *priceLabel;

//输入价格textfield
@property (nonatomic) UITextField        *priceTextField;

@end

NS_ASSUME_NONNULL_END
