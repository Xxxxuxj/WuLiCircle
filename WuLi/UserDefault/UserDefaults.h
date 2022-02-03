//
//  UserDefaults.h
//  WuLi
//
//  Created by Mac on 2021/12/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserInformationModel.h"
#import <BmobSDK/Bmob.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserDefaults : NSObject



//解档头像的图片
+ (void)setImage:(NSData *)img;

//解档头像被压缩后的图片
+ (void)setImageCompression:(NSData *)img;

//解档UserInformationModel  只存一个
+ (void)setUser:(UserInformationModel *)model;

//归档保存在本地的用户
+ (UserInformationModel *)          getUser;

//归档保存在本地的头像
+ (UIImage *)                        getImage;

//归档保存在本地压缩后的头像
+ (UIImage *)                        getImageCompression;

//删除解档在本地的头像
+(void)deleteImage;

//删除解档在本地的用户
+(void)deleteUser;



@end

NS_ASSUME_NONNULL_END
