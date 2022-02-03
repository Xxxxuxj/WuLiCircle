//
//  ImageScrollTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ImageScrollTableViewCell : UITableViewCell
@property (nonatomic) ImageScrollView           *imgView;
@property (nonatomic) UIView                    *pageView;
@property (nonatomic) UILabel                   *pageLabel;
@property (nonatomic) NSArray                   *picArray;

- (void)layoutWithImgCount:(NSInteger )count IamgeArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
