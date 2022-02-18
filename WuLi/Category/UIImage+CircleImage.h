//
//  UIImage+CircleImage.h
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CircleImage)

@property (nonatomic) NSString *imageName;
//将图片裁剪成圆形
- (UIImage *)circleImage;
@end

NS_ASSUME_NONNULL_END
