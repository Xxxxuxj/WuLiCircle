//
//  HomeView.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"
#import "headerCollectionReusableView.h"
#import "LabelScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeView : UIView

@property (nonatomic) UIScrollView          *homeScrollView;

@property (nonatomic) LabelScrollView       *labelScrollView;

@property (nonatomic) UIProgressView        *homeProgressView;

@property (nonatomic) UICollectionView      *collection;

@property (nonatomic) NSArray               *modelArray;

-(void)layoutWithModelArray:(NSArray *)modelArray;

@end

NS_ASSUME_NONNULL_END
