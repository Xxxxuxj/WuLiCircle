//
//  CommentTableViewCell.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "UserDefaults.h"
#import "UserStatus.h"
#import "UIImage+CircleImage.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell
@property (nonatomic) UIView                *replyView;
@property (nonatomic) NSMutableArray        *replyArray;
@property (nonatomic) NSInteger             replyCount;
@property (nonatomic) UILabel               *nameLabel;
@property (nonatomic) UIButton              *headImageBtn;
@property (nonatomic) UIButton              *likeBtn;
@property (nonatomic) UIButton              *moreReplyBtn;
@property (nonatomic) UILabel               *likeCountLabel;
@property (nonatomic) UILabel               *replyLabel;
@property (nonatomic) UILabel               *timeLabel;
@property (nonatomic) BmobObject            *comment;
-(void)layoutWithComment:(BmobObject *)comment;
@end

NS_ASSUME_NONNULL_END
