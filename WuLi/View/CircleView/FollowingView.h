//
//  FollowingView.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowingView : UIView

@property (nonatomic) UICollectionView *collection;

@property (nonatomic) NSArray *modelArray;

-(void)layoutWithModelArray:(NSArray *)modelArray;

@end

NS_ASSUME_NONNULL_END
