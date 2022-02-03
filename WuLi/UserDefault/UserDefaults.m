//
//  UserDefaults.m
//  WuLi
//
//  Created by Mac on 2021/12/1.
//

#import "UserDefaults.h"

@implementation UserDefaults

//解档头像的图片
+ (void)setImage:(NSData *)img{
    [[NSUserDefaults standardUserDefaults] setObject:img forKey:@"headImg"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setImageCompression:(NSData *)img{
    [[NSUserDefaults standardUserDefaults] setObject:img forKey:@"headImgCompression"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



//解档UserInformationModel  只存一个
+ (void)setUser:(UserInformationModel *)model{
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:NO error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//归档保存在本地的用户
+ (UserInformationModel *)getUser{
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"]];
}

//归档保存在本地的头像
+ (UIImage *)getImage{
    return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headImg"] ];
}

+ (UIImage *)getImageCompression{
    return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headImgCompression"] ];
}


//删除解档在本地的头像
+(void)deleteImage{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headImg"];
}

//删除解档在本地的用户
+(void)deleteUser{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userModel"];
}



@end
