//
//  HomeCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>
#import "CircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell



@property (nonatomic) UIButton                  *headBtn;
@property (nonatomic) UIButton                  *forwardBtn;
@property (nonatomic) UIButton                  *commentBtn;
@property (nonatomic) UIButton                  *likebtn;
@property (nonatomic) UIButton                  *functionBtn;
@property (nonatomic) UILabel                   *nameLabel;
@property (nonatomic) UILabel                   *contextLabel;
@property (nonatomic) UILabel                   *timeLabel;


-(void)layoutWithCircleModel:(CircleModel *)model;
@end

NS_ASSUME_NONNULL_END
