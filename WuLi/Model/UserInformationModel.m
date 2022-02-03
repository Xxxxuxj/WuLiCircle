//
//  UserInformationModel.m
//  WuLi
//
//  Created by Mac on 2021/11/30.
//

#import "UserInformationModel.h"

@implementation UserInformationModel

+(UserInformationModel *)configWithDic:(NSDictionary *)dic{
    UserInformationModel *model=[UserInformationModel new];
    model.userId=[dic objectForKey:@"userId"];
    model.phoneNumber=[dic objectForKey:@"phoneNumber"];
    model.password=[dic objectForKey:@"password"];
    model.userName=[dic objectForKey:@"userName"];
    model.headImageUrl=[dic objectForKey:@"headImageUrl"];
    model.headImageUrlCompression=[dic objectForKey:@"headImageUrlCompression"];
    model.fansCount=[dic objectForKey:@"fansCount"] ;
    model.followingCount=[dic objectForKey:@"followingCount"];
    model.fansUsers=[dic objectForKey:@"fansUsers"] ;
    model.followingUsers=[dic objectForKey:@"followingUsers"];
    model.releasedCircleIDs=[dic objectForKey:@"releasedCircleIDs"];
    model.releasedCommodityIDs=[dic objectForKey:@"releasedCommodityIDs"];
    model.userSign=[dic objectForKey:@"userSign"];
    
    return model;
}

+(UserInformationModel *)configWithBmobObject:(BmobObject *)  user{
    
    UserInformationModel *model=[UserInformationModel new];
    
    NSMutableDictionary *dic=[user valueForKey:@"dataDic"];
    model.userId=[dic valueForKey:@"objectId"];
    model.phoneNumber=[dic valueForKey:@"phoneNumber"];
    model.password=[dic valueForKey:@"password"];
    model.userName=[dic valueForKey:@"username"];
    model.headImageUrl=[dic valueForKey:@"headImageUrl"];
    model.fansCount=[dic valueForKey:@"fansCount"];
    model.followingCount=[dic valueForKey:@"followingCount"];
    model.fansUsers=[dic valueForKey:@"fansUsers"] ;
    model.followingUsers=[dic objectForKey:@"followingUsers"];
    model.headImageUrlCompression=[dic objectForKey:@"headImageUrl-C"];
    model.releasedCircleIDs=[dic valueForKey:@"releasedCircleIDs"];
    model.releasedCommodityIDs=[dic valueForKey:@"releasedCommodityIDs"];
    model.userSign=[dic valueForKey:@"userSign"];
    
    return model;
}




- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userName forKey:@"userSign"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
    [aCoder encodeObject:self.headImageUrlCompression forKey:@"headImageUrlCompression"];
    [aCoder encodeObject:self.fansCount forKey:@"fansCount"];
    [aCoder encodeObject:self.followingCount forKey:@"followingCount"];
    [aCoder encodeObject:self.fansUsers forKey:@"fansUsers"];
    [aCoder encodeObject:self.followingUsers forKey:@"followingUsers"];
    [aCoder encodeObject:self.releasedCircleIDs forKey:@"releasedCircleIDs"];
    [aCoder encodeObject:self.releasedCommodityIDs forKey:@"releasedCommodityIDs"];
}
 
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userSign = [aDecoder decodeObjectForKey:@"userSign"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.headImageUrl = [aDecoder decodeObjectForKey:@"headImageUrl"];
        self.headImageUrlCompression = [aDecoder decodeObjectForKey:@"headImageUrlCompression"];
        self.fansCount = [aDecoder decodeObjectForKey:@"fansCount"];
        self.followingCount = [aDecoder decodeObjectForKey:@"followingCount"];
        self.fansUsers = [aDecoder decodeObjectForKey:@"fansUsers"];
        self.followingUsers = [aDecoder decodeObjectForKey:@"followingUsers"];
        self.releasedCircleIDs = [aDecoder decodeObjectForKey:@"releasedCircleIDs"];
        self.releasedCommodityIDs = [aDecoder decodeObjectForKey:@"releasedCommodityIDs"];
    }
    return self;
}

@end
