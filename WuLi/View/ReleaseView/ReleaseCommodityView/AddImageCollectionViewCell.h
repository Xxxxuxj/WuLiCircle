//
//  AddImageCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddImageCollectionViewCell : UICollectionViewCell


//cell中的imgBtn
@property (nonatomic) UIButton      *imgBtn;

//cell中的deleteBtn
@property (nonatomic) UIButton      *deleteBtn;

//每个cell的index
@property (nonatomic) NSInteger     index;

//布局cell 根据img和index
-(void)layoutWithImage:(UIImage *)img index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
