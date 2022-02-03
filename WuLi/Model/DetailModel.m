//
//  DetailModel.m
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import "DetailModel.h"

@implementation DetailModel

/*
 @property (nonatomic) NSString              *desString;
 @property (nonatomic) NSString              *userName;
 @property (nonatomic) NSString              *locationString;
 @property (nonatomic) NSString              *priceString;
 @property (nonatomic) NSMutableArray        *imgArray;
 @property (nonatomic) NSString              *headImgPath;
 @property (nonatomic) NSMutableArray        *articleArray;
 */


+(instancetype)configWithDic:(NSDictionary *)dic{
    DetailModel* model=[DetailModel new];
    
    model.desString=[dic objectForKey:@"desString"];
    model.userName=[dic objectForKey:@"userName"];
    model.locationString=[dic objectForKey:@"locationString"];
    model.priceString=[dic objectForKey:@"priceString"];
    model.imgArray=[dic objectForKey:@"imgArray"];
    model.headImgPath=[dic objectForKey:@"headImgPath"];
    model.articleArray=[dic objectForKey:@"articleArray"];
    
    return model;
}
@end
