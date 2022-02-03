//
//  SectionFlowLayout.h
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import <UIKit/UIKit.h>

@class SectionFlowLayout;



@protocol SectionFlowLayoutDelegate <NSObject>
// 行间距
- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section;

// 列间距
- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

// sectionInset
- (UIEdgeInsets)contentInsetOfSectionAtIndex:(NSInteger)section;

@required

// section的数量
- (NSInteger)numberOfSection;

// cell的大小
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *_Nonnull)indexPath;

 // section的列数
- (NSInteger)numberOfColumnInSectionAtIndex:(NSInteger)section;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SectionFlowLayout : UICollectionViewFlowLayout


//delegate
@property (nonatomic,assign) id<SectionFlowLayoutDelegate> flowDelegate;

// 代替collectionView.contentInset
@property (nonatomic, assign) UIEdgeInsets contentInset;  

@end

NS_ASSUME_NONNULL_END
