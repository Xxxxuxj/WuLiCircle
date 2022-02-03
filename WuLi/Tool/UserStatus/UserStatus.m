//
//  UserStatus.m
//  WuLi
//
//  Created by Mac on 2021/12/2.
//

#import "UserStatus.h"


static UserStatus* _instance;
@implementation UserStatus

//单例
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[UserStatus alloc]init];
        _instance.ifOnline=NO;
    });
    return _instance;
}

//用户登录
- (void) registerUser{
    _instance.ifOnline=YES;
    
    BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
    [bquery whereKey:@"objectId" equalTo:[UserDefaults getUser].userId];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if(array){
                _instance.currentUser=array[0];
            }else{
                NSLog(@"%@",error);
            }
    }];
}

//用户退出登录
- (void) exitUser{
    _instance.ifOnline=NO;
}

//用户是否登录
- (BOOL) getUserStatus{
    return _instance.ifOnline;
}

//关注用户
- (void) followUser:(NSString *)userID{
    

    
    [_instance.currentUser addObjectsFromArray:@[userID] forKey:@"followingUsers"];
    NSString *newFollowingCount=[NSString stringWithFormat:@"%d",[[UserDefaults getUser].followingCount intValue]+1 ];
    [_instance.currentUser setObject:newFollowingCount  forKey:@"followingCount"];
    [_instance.currentUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                [UserDefaults deleteUser];
                BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
                [bquery whereKey:@"objectId" equalTo:[UserDefaults getUser].userId];
                [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array){
                            [UserDefaults setUser:[UserInformationModel configWithBmobObject:_instance.currentUser]];
                            _instance.currentUser=array[0];
                        }else{
                            NSLog(@"%@",error);
                        }
                }];
                
            }else{
                NSLog(@"%@",error);
            }
    }];
    
/*
 1.被关注的用户的fansUser需要添加用户
 2.app打开之后 mineViewController的viewdidload后 需要从网络上加载数据更新UserDefaults的数据
 3.评论的回复和回复后的评论样式
 4.商品描述的展开
 */
    

}

- (void) followUser:(NSString *)userID successBlock:(void(^)(BOOL isSuccessful))block{
    NSLog(@"%@",userID);
    
    [_instance.currentUser addObjectsFromArray:@[userID] forKey:@"followingUsers"];
    NSString *newFollowingCount=[NSString stringWithFormat:@"%d",[[UserDefaults getUser].followingCount intValue]+1 ];
    [_instance.currentUser setObject:newFollowingCount  forKey:@"followingCount"];
    [_instance.currentUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                isSuccessful=YES;
                block(isSuccessful);
                [UserDefaults deleteUser];
                BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
                [bquery whereKey:@"objectId" equalTo:[UserDefaults getUser].userId];
                [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array){
                            
                            _instance.currentUser=array[0];
                            [UserDefaults setUser:[UserInformationModel configWithBmobObject:_instance.currentUser]];
                        }else{
                            NSLog(@"%@",error);
                        }
                }];
            }else{
                NSLog(@"%@",error);
            }
    }];
    
    
    
}




//取消关注用户
- (void) cancleFollowUser:(NSString *)userID{
    
    [_instance.currentUser removeObjectsInArray:@[userID] forKey:@"followingUsers"];
    NSString *newFollowingCount=[NSString stringWithFormat:@"%d",[[UserDefaults getUser].followingCount intValue]-1 ];
    [_instance.currentUser setObject:newFollowingCount  forKey:@"followingCount"];
    [_instance.currentUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                [UserDefaults deleteUser];
                [UserDefaults setUser:[UserInformationModel configWithBmobObject:_instance.currentUser]];
            }
    }];

    

}

- (void) cancleFollowUser:(NSString *)userID successBlock:(void(^)(BOOL isSuccessful))block{
    
    [_instance.currentUser removeObjectsInArray:@[userID] forKey:@"followingUsers"];
    NSString *newFollowingCount=[NSString stringWithFormat:@"%d",[[UserDefaults getUser].followingCount intValue]-1 ];
    [_instance.currentUser setObject:newFollowingCount  forKey:@"followingCount"];
    [_instance.currentUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                isSuccessful=YES;
                block(isSuccessful);
                [UserDefaults deleteUser];
                BmobQuery *bquery=[BmobQuery queryWithClassName:@"User"];
                [bquery whereKey:@"objectId" equalTo:[UserDefaults getUser].userId];
                [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if(array){
                            
                            _instance.currentUser=array[0];
                            [UserDefaults setUser:[UserInformationModel configWithBmobObject:_instance.currentUser]];
                            
                        }else{
                            NSLog(@"%@",error);
                        }
                }];
            }
    }];
    
}


//点赞评论
- (void) likeComment:(BmobObject *)comment{
    NSString *likeCount=[comment objectForKey:@"likeCount"];
    NSString *newLikeCount=[NSString stringWithFormat:@"%ld",[likeCount integerValue]+1];
    [comment setObject:newLikeCount forKey:@"likeCount"];
    [comment addObjectsFromArray:@[[self.currentUser objectId]] forKey:@"likeUsers"];
    
    [comment updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            
        }else{
            
        }
    }];
}

//取消点赞评论
- (void) cancleLikeComment:(BmobObject *)comment{
    NSString *likeCount=[comment objectForKey:@"likeCount"];
    NSString *newLikeCount=[NSString stringWithFormat:@"%ld",[likeCount integerValue]-1];
    [comment setObject:newLikeCount forKey:@"likeCount"];
    [comment removeObjectsInArray:@[[self.currentUser objectId]] forKey:@"likeUsers"];
    [comment updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if(isSuccessful){
            
        }else{
            
        }
    }];
}



@end
