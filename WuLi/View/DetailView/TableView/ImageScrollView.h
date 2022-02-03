//
//  ImageScrollView.h
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageScrollView : UIScrollView
@property (nonatomic) NSInteger         imgCount;


- (instancetype)initWithFrame:(CGRect)frame imgCount:(NSInteger )count;
-(void)layoutWithIamgeArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
