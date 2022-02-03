//
//  DetailModel.h
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

@property (nonatomic) NSString              *desString;
@property (nonatomic) NSString              *userName;
@property (nonatomic) NSString              *locationString;
@property (nonatomic) NSString              *priceString;
@property (nonatomic) NSMutableArray        *imgArray;
@property (nonatomic) NSString              *headImgPath;
@property (nonatomic) NSMutableArray        *articleArray;

+(instancetype)configWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
