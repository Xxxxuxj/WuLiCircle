//
//  ReleaseCommodityView.h
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import <UIKit/UIKit.h>
#import "TitleCollectionViewCell.h"
#import "TextCollectionViewCell.h"
#import "AddImageCollectionViewCell.h"
#import "CommodityLocationCollectionViewCell.h"
#import "PriceCollectionViewCell.h"
#import "SubmitCollectionViewCell.h"
#import "CommodityModel.h"
#import <BmobSDK/Bmob.h>
#import "UserDefaults.h"
#import "UIImage+Compression.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseCommodityView : UIView



//最下面的一层scrollView
@property (nonatomic) UIScrollView              *mainScrollView;

//选择商品图片的collectionView
@property (nonatomic) UICollectionView          *imgCollectionView;

//存放选择的图片的array
@property (nonatomic) NSMutableArray            *imgArray;

//弹出的键盘的坐标中的Y
@property (nonatomic) int                       keyboardY;

//信息存入的CommodityModel
@property (nonatomic) CommodityModel            *model;


//更新存放选择的图片的array
-(void)updateImageArray:(NSArray *)imgArray;

@end

NS_ASSUME_NONNULL_END
