//
//  GetCommodity.h
//  WuLi
//
//  Created by Mac on 2021/12/29.
//

#import <Foundation/Foundation.h>
#import "UserInformationModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^resultOfGetBlock)(BOOL,NSMutableArray*);
@interface GetCommodityOrCircle : NSObject


+(NSArray *)getCommodityForCount:(NSInteger )number ForUser:(NSString *)userID;

+(NSArray *)getCommodityForCount:(NSInteger )number WithLocation:(NSString *)location ForUser:(NSString *)userID resultOfGetBlock:(void(^)(BOOL isSuccessful,NSArray *prearray))block;

+(void)getUserCommodity:(NSString *)userID resultOfGetBlock:(void(^)(BOOL isSuccessful,NSMutableArray * _Nonnull cArray))block;

+(NSArray *)getCircleForCount:(NSInteger )number ForUser:(NSString *)userID;

+(NSArray *)getCircleForCount:(NSInteger )number  WithFollowingUserArray:(NSArray *)followingArray;



@end

NS_ASSUME_NONNULL_END
