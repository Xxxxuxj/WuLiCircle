//
//  LabelScrollView.h
//  WuLi
//
//  Created by Mac on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "LabelCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LabelScrollView : UIScrollView


@property (nonatomic) UICollectionView      *collection;
@property (nonatomic) NSMutableArray        *labelTextArray;
@property (nonatomic) NSMutableArray        *labelBtnArray;
@property (nonatomic) NSInteger             currentBtnIndex;
@property (nonatomic) UIButton              *labelBtn1;
@property (nonatomic) UIButton              *labelBtn2;
@property (nonatomic) UIButton              *labelBtn3;
@property (nonatomic) UIButton              *labelBtn4;
@property (nonatomic) UIButton              *labelBtn5;
@property (nonatomic) UIButton              *labelBtn6;
@property (nonatomic) UIButton              *labelBtn7;
@property (nonatomic) UIButton              *labelBtn8;
@property (nonatomic) UIButton              *labelBtn9;
@property (nonatomic) UIButton              *labelBtn10;
@property (nonatomic) UILabel               *indexLabel;

-(void)turnToBtn:(NSInteger )newBtnIndex;
@end

NS_ASSUME_NONNULL_END
