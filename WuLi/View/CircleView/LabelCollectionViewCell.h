//
//  LabelCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelCollectionViewCell : UICollectionViewCell


@property (nonatomic) UILabel   *label;

-(void)layoutWithLabelText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
