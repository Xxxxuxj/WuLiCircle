//
//  UserInformationModel.h
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserInformationModel : NSObject <NSCoding>

@property (nonatomic) NSString      *userId;
@property (nonatomic) NSString      *phoneNumber;
@property (nonatomic) NSString      *password;
@property (nonatomic) NSString      *userName;
@property (nonatomic) NSString      *userSign;
@property (nonatomic) NSString      *headImageUrl;
@property (nonatomic) NSString      *headImageUrlCompression;
@property (nonatomic) NSString      *fansCount;
@property (nonatomic) NSArray       *fansUsers;
@property (nonatomic) NSString      *followingCount;
@property (nonatomic) NSArray       *followingUsers;
@property (nonatomic) NSArray       *releasedCircleIDs;
@property (nonatomic) NSArray       *releasedCommodityIDs;

+(UserInformationModel *)configWithDic:(NSDictionary *)                 dic;
+(UserInformationModel *)configWithBmobObject:(BmobObject *)            user;

@end

NS_ASSUME_NONNULL_END
