//
//  FollowingCollectionViewCell.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowingCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIButton                  *headBtn;
@property (nonatomic) UILabel                   *nameLabel;


@property (nonatomic) UIButton                  *forwardBtn;
@property (nonatomic) UIButton                  *commentBtn;
@property (nonatomic) UIButton                  *likebtn;
@property (nonatomic) UIButton                  *functionBtn;

@property (nonatomic) UILabel                   *contextLabel;
@property (nonatomic) UILabel                   *timeLabel;

@end

NS_ASSUME_NONNULL_END
