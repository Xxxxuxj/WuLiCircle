//
//  CircleModel.h
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleModel : NSObject <NSCoding>

@property (nonatomic) NSString              *circleId;
@property (nonatomic) NSString              *userId;
@property (nonatomic) NSString              *circleContent;
@property (nonatomic) NSString              *circleTitle;
@property (nonatomic) NSMutableArray        *labelArray;
@property (nonatomic) NSArray               *picArray;
@property (nonatomic) NSArray               *commentArray;

@end

NS_ASSUME_NONNULL_END
