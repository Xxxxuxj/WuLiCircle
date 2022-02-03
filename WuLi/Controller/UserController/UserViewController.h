//
//  UserViewController.h
//  WuLi
//
//  Created by Mac on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController

@property (nonatomic) UserView *userView;

-(void)layoutWithUserID:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
