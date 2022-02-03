//
//  CommodityCommentModel.h
//  WuLi
//
//  Created by Mac on 2021/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommodityCommentModel : NSObject

@property (nonatomic) NSString      *commodityCommentId;
@property (nonatomic) NSString      *userID;
@property (nonatomic) NSString      *content;
@property (nonatomic) NSString      *likeCount;
@property (nonatomic) NSArray       *replyArray;
@property (nonatomic) NSString      *userName;
@property (nonatomic) NSString      *headImageUrl;

@end

NS_ASSUME_NONNULL_END
