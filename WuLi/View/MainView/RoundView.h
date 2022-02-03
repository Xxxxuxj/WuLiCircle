//
//  RoundView.h
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoundView : UIView

@property (nonatomic,strong) UIScrollView   *scrollView;
@property (nonatomic) NSMutableArray        *imgArray;
@property (nonatomic) UIPageControl         *pageControl;
@property (nonatomic,strong) NSTimer        *__nullable timer;

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
