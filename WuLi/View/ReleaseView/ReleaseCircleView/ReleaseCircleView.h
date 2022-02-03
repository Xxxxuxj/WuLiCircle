//
//  ReleaseCircleView.h
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import <UIKit/UIKit.h>
#import "CircleModel.h"
#import "CircleTitleCollectionViewCell.h"
#import "CircleContentCollectionViewCell.h"
#import "CircleAddImageCollectionViewCell.h"
#import "CircleLabelCollectionViewCell.h"
#import "CircleSubmitCollectionViewCell.h"
#import <BmobSDK/Bmob.h>
#import "UserDefaults.h"
#import "WMZDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseCircleView : UIView


//最下面的一层scrollView
@property (nonatomic) UIScrollView              *mainScrollView;

//选择商品图片的collectionView
@property (nonatomic) UICollectionView          *imgCollectionView;

//存放选择的图片的array
@property (nonatomic) NSMutableArray            *imgArray;

//存放标签的array
@property (nonatomic) NSMutableArray            *labelArray;

//弹出的键盘的坐标中的Y
@property (nonatomic) int                       keyboardY;

//信息存入的CircleModel
@property (nonatomic) CircleModel               *model;




//更新存放选择的图片的array
-(void)updateImageArray:(NSArray *)imgArray;


@end

NS_ASSUME_NONNULL_END
