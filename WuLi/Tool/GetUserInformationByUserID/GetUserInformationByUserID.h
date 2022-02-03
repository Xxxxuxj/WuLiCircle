//
//  GetUserInformationByUserID.h
//  WuLi
//
//  Created by Mac on 2021/12/29.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
#import "UserInformationModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^userInformationBlock)(UserInformationModel*);

@interface GetUserInformationByUserID : NSObject


+(void)getUserInformationByUserID:(NSString *)userID resultBlock:(void(^)(UserInformationModel *model))block;


@end

NS_ASSUME_NONNULL_END
