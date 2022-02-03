//
//  RoundCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import <UIKit/UIKit.h>
#import "RoundView.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoundCollectionViewCell : UICollectionViewCell

@property (nonatomic) RoundView         *roundView;

-(void)layoutWithImageArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
