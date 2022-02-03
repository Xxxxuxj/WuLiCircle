//
//  RecommendModel.h
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendModel : NSObject

@property (nonatomic) NSString              *desString;
@property (nonatomic) NSString              *userID;
@property (nonatomic) NSString              *location;
@property (nonatomic) NSString              *price;
@property (nonatomic) NSArray               *picArray;
@property (nonatomic) NSString              *title;
@property (nonatomic) NSMutableArray        *commentArray;


+(RecommendModel* )configWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
