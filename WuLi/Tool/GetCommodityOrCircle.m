//
//  GetCommodity.m
//  WuLi
//
//  Created by Mac on 2021/12/29.
//

#import "GetCommodityOrCircle.h"

@implementation GetCommodityOrCircle


+(NSArray *)getCommodityForCount:(NSInteger )commodityNumber ForUser:(NSString *)userID{
    
    __block NSArray *resultArray=[[NSArray alloc]init];
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Commodity"];
    
    [bquery whereKey:@"userID" notEqualTo:userID];
    [bquery setLimit:commodityNumber];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(!error){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"getRecommendArray" object:nil userInfo:@{@"array":array}];
            }else{
                NSLog(@"%@",error);
            }
    }];
    
    return resultArray;
    
}



+(NSArray *)getCommodityForCount:(NSInteger )commodityNumber WithLocation:(NSString *)location ForUser:(NSString *)userID resultOfGetBlock:(void(^)(BOOL isSuccessful,NSArray *prearray))block{
    
    __block NSArray *resultArray=[[NSArray alloc]init];
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Commodity"];
    
    [bquery whereKey:@"userID" notEqualTo:userID];
    [bquery setLimit:commodityNumber];
    [bquery whereKey:@"location" equalTo:location];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(!error){
                resultArray=array;
                block(YES,array);
            }else{
                NSLog(@"%@",error);
            }
    }];
    
    return resultArray;
    
}

+(void)getUserCommodity:(NSString *)userID resultOfGetBlock:(void(^)(BOOL isSuccessful,NSMutableArray * _Nonnull cArray))block{
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Commodity"];
    [bquery whereKey:@"userID" equalTo:userID];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if(error) NSLog(@"%@",error);
        else{
            block(true,(NSMutableArray*)array);
        }
    }];
}








+(NSArray *)getCircleForCount:(NSInteger )circleNumber ForUser:(NSString *)userID{
    
    __block NSArray *resultArray=[[NSArray alloc]init];
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Circle"];
    
    [bquery whereKey:@"userID" notEqualTo:userID];
    [bquery setLimit:circleNumber];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(!error){
                resultArray=array;
            }else{
                NSLog(@"%@",error);
            }
    }];
    
    return resultArray;
    
}



+(NSArray *)getCircleForCount:(NSInteger )circleNumber  WithFollowingUserArray:(NSArray *)followingArray{
    
    __block NSArray *resultArray=[[NSArray alloc]init];
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"Circle"];
    
    for(int i=0;i<followingArray.count;i++){
        [bquery whereKey:@"userID" equalTo:followingArray[i]];
    }
    
    [bquery setLimit:circleNumber];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(!error){
                resultArray=array;
            }else{
                NSLog(@"%@",error);
            }
    }];
    
    return resultArray;
    
}


@end
