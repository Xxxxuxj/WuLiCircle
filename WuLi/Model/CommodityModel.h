//
//  CommodityModel.h
//  WuLi
//
//  Created by Mac on 2021/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommodityModel : NSObject <NSCoding>


@property (nonatomic) NSString      *commodityId;
@property (nonatomic) NSString      *userId;
@property (nonatomic) NSString      *commodityDescription;
@property (nonatomic) NSString      *commodityTitle;
@property (nonatomic) NSString      *price;
@property (nonatomic) NSString      *location;
@property (nonatomic) NSString      *firstPicUrl;
@property (nonatomic) NSArray       *picArray;
@property (nonatomic) NSArray       *commentArray;
@property (nonatomic) NSString      *userName;
@property (nonatomic) NSString      *headImageUrl;
@property (nonatomic) NSString      *headImageUrlCompression;

-(void)configWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
