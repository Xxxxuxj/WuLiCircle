//
//  RecommendModel.m
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import "RecommendModel.h"                                                                 

@implementation RecommendModel


//@property (nonatomic) NSString              *desString;
//@property (nonatomic) NSString              *userID;
//@property (nonatomic) NSString              *location;
//@property (nonatomic) NSString              *price;
//@property (nonatomic) NSMutableArray        *picArray;
//@property (nonatomic) NSString              *title;
//@property (nonatomic) NSMutableArray        *commentArray;


+(RecommendModel* )configWithDic:(NSDictionary *)dic{
    RecommendModel* model=[RecommendModel new];
    
    model.desString=[dic objectForKey:@"desString"];
    model.userID=[dic objectForKey:@"userID"];
    model.location=[dic objectForKey:@"location"];
    model.price=[dic objectForKey:@"price"];
    model.picArray=[dic objectForKey:@"picArray"];
    model.title=[dic objectForKey:@"title"];
    model.commentArray=[dic objectForKey:@"commentArray"];
    
    return model;
}


@end
