//
//  CommodityModel.m
//  WuLi
//
//  Created by Mac on 2021/12/16.
//

#import "CommodityModel.h"

@implementation CommodityModel

/*
 @property (nonatomic) NSString      *commodityId;
 @property (nonatomic) NSString      *userId;
 @property (nonatomic) NSString      *commodityDescription;
 @property (nonatomic) NSString      *commodityTitle;
 @property (nonatomic) NSString      *price;
 @property (nonatomic) NSString      *location;
 @property (nonatomic) NSArray       *picArray;
 @property (nonatomic) NSArray       *commentArray;
 @property (nonatomic) NSString      *userName;
 @property (nonatomic) NSString      *headImageUrl;
 */
-(void)configWithDic:(NSDictionary *)dic{
    self.commodityId = [dic valueForKey:@"objectId"];
    self.userId = [dic valueForKey:@"userID"];
    self.commodityDescription = [dic valueForKey:@"description"];
    self.commodityTitle = [dic valueForKey:@"title"];
    self.price = [dic valueForKey:@"price"];
    self.location = [dic valueForKey:@"location"];
    self.firstPicUrl=[dic valueForKey:@"firstPicUrl-C"];
    self.picArray = [dic valueForKey:@"picArray"];
    self.commentArray = [dic valueForKey:@"commentArray"];
    self.userName = [dic valueForKey:@"username"];
    self.headImageUrl = [dic valueForKey:@"headImageUrl"];
    if([dic valueForKey:@"headImageUrl-C"]){
        self.headImageUrlCompression = [dic valueForKey:@"headImageUrl-C"];
    }else{
        self.headImageUrlCompression = [dic valueForKey:@"headImageUrlCompression"];
    }
}






- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.commodityId forKey:@"commodityId"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.commodityDescription forKey:@"commodityDescription"];
    [aCoder encodeObject:self.commodityTitle forKey:@"commodityTitle"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.firstPicUrl forKey:@"firstPicUrl"];
    [aCoder encodeObject:self.picArray forKey:@"picArray"];
    [aCoder encodeObject:self.commentArray forKey:@"commentArray"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
    [aCoder encodeObject:self.headImageUrlCompression forKey:@"headImageUrlCompression"];
}
 
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.commodityId = [aDecoder decodeObjectForKey:@"commodityId"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.commodityDescription = [aDecoder decodeObjectForKey:@"commodityDescription"];
        self.commodityTitle = [aDecoder decodeObjectForKey:@"commodityTitle"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.firstPicUrl = [aDecoder decodeObjectForKey:@"firstPicUrl"];
        self.picArray = [aDecoder decodeObjectForKey:@"picArray"];
        self.commentArray = [aDecoder decodeObjectForKey:@"commentArray"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.headImageUrl = [aDecoder decodeObjectForKey:@"headImageUrl"];
        self.headImageUrlCompression = [aDecoder decodeObjectForKey:@"headImageUrlCompression"];
    }
    return self;
}



@end
