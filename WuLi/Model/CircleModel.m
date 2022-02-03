//
//  CircleModel.m
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import "CircleModel.h"

@implementation CircleModel

//@property (nonatomic) NSString      *circleId;
//@property (nonatomic) NSString      *userId;
//@property (nonatomic) NSString      *circleContent;
//@property (nonatomic) NSString      *circleTitle;
//@property (nonatomic) NSString      *label;
//@property (nonatomic) NSArray       *picArray;
//@property (nonatomic) NSArray       *commentArray;




- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.circleId forKey:@"circleId"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.circleContent forKey:@"circleContent"];
    [aCoder encodeObject:self.circleTitle forKey:@"circleTitle"];
    [aCoder encodeObject:self.labelArray forKey:@"labelArray"];
    [aCoder encodeObject:self.picArray forKey:@"picArray"];
    [aCoder encodeObject:self.commentArray forKey:@"commentArray"];
}
 
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.circleId = [aDecoder decodeObjectForKey:@"circleId"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.circleContent = [aDecoder decodeObjectForKey:@"circleContent"];
        self.circleTitle = [aDecoder decodeObjectForKey:@"circleTitle"];
        self.labelArray = [aDecoder decodeObjectForKey:@"labelArray"];
        self.picArray = [aDecoder decodeObjectForKey:@"picArray"];
        self.commentArray = [aDecoder decodeObjectForKey:@"commentArray"];
    }
    return self;
}


@end
