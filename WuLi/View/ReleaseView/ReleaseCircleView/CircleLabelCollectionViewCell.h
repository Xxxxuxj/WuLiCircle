//
//  CircleLabelCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleLabelCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIButton *labelBtn;
@property (nonatomic) BOOL      ifSelected;

-(void)setLabelText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
