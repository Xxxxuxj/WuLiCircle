//
//  UserStatus.h
//  WuLi
//
//  Created by Mac on 2021/12/2.
//

#import <Foundation/Foundation.h>
#import "UserDefaults.h"

NS_ASSUME_NONNULL_BEGIN

/*
  该类是用户的登录状态 与UserDefaults有区别
 */

typedef void (^resultBlock)(BOOL);

@interface UserStatus : NSObject

//是否登录在线
@property (nonatomic) BOOL              ifOnline;

//登录在线的用户
@property (nonatomic) BmobObject        *currentUser;

//单例
+ (instancetype)sharedInstance;

//登录用户时需要调用 改变状态
- (void) registerUser;

//退出用户时需要调用 改变状态
- (void) exitUser;

//得到用户的状态
- (BOOL) getUserStatus;

//关注用户
- (void) followUser:(NSString *)userID;
- (void) followUser:(NSString *)userID successBlock:(void(^)(BOOL isSuccessful))block;

//取消关注用户
- (void) cancleFollowUser:(NSString *)userID;
- (void) cancleFollowUser:(NSString *)userID successBlock:(void(^)(BOOL isSuccessful))block;

//点赞评论
- (void) likeComment:(BmobObject *)comment;

//取消点赞评论
- (void) cancleLikeComment:(BmobObject *)comment;



@end

NS_ASSUME_NONNULL_END
