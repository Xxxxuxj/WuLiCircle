//
//  ReleaseCommodityViewController.h
//  WuLi
//
//  Created by Mac on 2021/12/13.
//

#import <UIKit/UIKit.h>
#import "ReleaseCommodityView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseCommodityViewController : UIViewController


@property (nonatomic)ReleaseCommodityView       *releaseView;

-(void)layoutWithImageArray:(NSArray *)imgArray;
@end

NS_ASSUME_NONNULL_END
