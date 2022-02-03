//
//  GetUserInformationByUserID.m
//  WuLi
//
//  Created by Mac on 2021/12/29.
//

#import "GetUserInformationByUserID.h"

@implementation GetUserInformationByUserID


+(void)getUserInformationByUserID:(NSString *)userID resultBlock:(void(^)(UserInformationModel *model))block{
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
    [bquery whereKey:@"objectId" equalTo:userID];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(error) NSLog(@"%@",error);
        else{
            block([UserInformationModel configWithBmobObject:array.firstObject]);
        }
    }];
}

/*
 1.[model valueForKey:@"userID"] 不要使用点语法 全部解决
 2.根据userID得到user的信息 在获取commodity时应该同时获取到布局需要的信息 即修改数据库和model 添加username和headImageUrl
 */

@end
