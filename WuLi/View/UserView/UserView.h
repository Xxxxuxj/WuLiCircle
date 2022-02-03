//
//  UserView.h
//  WuLi
//
//  Created by Mac on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "SectionFlowLayout.h"
#import "UserInformationTableViewCell.h"
#import "UserReleaseTableViewCell.h"
#import "UserReleaseHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserView : UIView

@property (nonatomic) UIView      *navigationView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UserInformationModel *model;

-(void)layoutWithUserID:(NSString *)ID;

@end

NS_ASSUME_NONNULL_END
