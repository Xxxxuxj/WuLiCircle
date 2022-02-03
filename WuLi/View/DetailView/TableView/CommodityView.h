//
//  CommodityView.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
#import "CommodityCommentModel.h"
#import "ImageScrollTableViewCell.h"
#import "CommodityInformationTableViewCell.h"
#import "ReleasedUserTableViewCell.h"
#import "CommentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommodityView : UIView

//commodity数据
@property (nonatomic) CommodityModel                            *model;
@property (nonatomic) UILabel                                   *pageLabel;
@property (nonatomic) UITableView                               *tableView;
@property (nonatomic) __block NSMutableArray                    *picArray;
@property (nonatomic) UIView                                    *commentView;
@property (nonatomic) UITextView                                *commentTextView;
@property (nonatomic) UIButton                                  *commentBtn;
@property (nonatomic) UIButton                                  *wantBtn;

- (instancetype)initWithFrame:(CGRect)frame model:(CommodityModel *)model;


@end

NS_ASSUME_NONNULL_END
