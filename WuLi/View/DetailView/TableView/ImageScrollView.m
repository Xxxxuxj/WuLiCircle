//
//  ImageScrollView.m
//  WuLi
//
//  Created by Mac on 2022/1/26.
//

#import "ImageScrollView.h"

@implementation ImageScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame imgCount:(NSInteger )count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgCount=count;
        //self.backgroundColor=[UIColor lightGrayColor];
        self.bounces=NO;
        self.showsVerticalScrollIndicator=false;
        self.showsHorizontalScrollIndicator=false;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
}

-(void)layoutWithIamgeArray:(NSArray *)array{
    self.contentSize=CGSizeMake(self.frame.size.width*array.count, self.frame.size.height);
    self.pagingEnabled=YES;
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    __block CGFloat imgViewX=0;
    
    for(int i=0;i<array.count;i++){
            UIImageView* imgView=[[UIImageView alloc]initWithFrame:CGRectMake(imgViewX,0, self.frame.size.width, self.frame.size.height)];
            imgView.image=array[i];
            //imgView.contentMode=UIViewContentModeScaleAspectFit;
            imgView.contentMode=UIViewContentModeScaleAspectFit;
            [self addSubview:imgView];
            imgViewX+=self.frame.size.width;
    }
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        //CGPoint offset=[[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changePage" object:nil userInfo:@{@"change":change}];
    }
}


@end
