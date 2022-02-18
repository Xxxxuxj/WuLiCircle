//
//  UIImage+CircleImage.m
//  WuLi
//
//  Created by Mac on 2021/11/28.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (id)imageName{
    return self.imageName;
}

-(void)setImageName:(NSString *)imageName{
    
}


//将图片裁剪成圆形
- (UIImage *)circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 方形变圆形
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
