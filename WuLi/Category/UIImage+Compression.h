//
//  UIImage+Compression.h
//  WuLi
//
//  Created by Mac on 2022/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compression)

- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;


@end

NS_ASSUME_NONNULL_END
