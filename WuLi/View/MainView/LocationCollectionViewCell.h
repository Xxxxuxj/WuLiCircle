//
//  LocationCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "UIImage+CircleImage.h"
#import "UIImage+Compression.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface LocationCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIButton          *userHeadBtn;
@property (nonatomic) UIButton          *leftBtn;
@property (nonatomic) UIButton          *midBtn;
@property (nonatomic) UIButton          *rightBtn;
@property (nonatomic) UILabel           *userNameLabel;
@property (nonatomic) UILabel           *timeLabel;
@property (nonatomic) UIImageView       *imgView1;
@property (nonatomic) UIImageView       *imgView2;
@property (nonatomic) UIImageView       *imgView3;


-(void)layoutWithModel:(RecommendModel *)model;

@end

NS_ASSUME_NONNULL_END
