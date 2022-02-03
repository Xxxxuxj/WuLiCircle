//
//  MainScrollView.h
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import <UIKit/UIKit.h>
#import "RecommendView.h"
#import "LocationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainScrollView : UIScrollView

@property (nonatomic) RecommendView     *recommendView;
@property (nonatomic) LocationView     *locationView;

@end

NS_ASSUME_NONNULL_END
