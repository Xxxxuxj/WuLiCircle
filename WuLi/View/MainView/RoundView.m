//
//  RoundView.m
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import "RoundView.h"

@interface RoundView() <UIScrollViewDelegate>

@end


@implementation RoundView

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSMutableArray *)array{
    self=[super initWithFrame:frame];
    
    self.imgArray=[[NSMutableArray alloc]init];
    [self.imgArray addObject:[array lastObject]];
    [self.imgArray addObjectsFromArray:array];
    [self.imgArray addObject:[array firstObject]];
    
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.scrollView.delegate=self;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.scrollView.layer setCornerRadius:10.0];
    [self.scrollView.layer masksToBounds];
    
    for(int i=0;i<self.imgArray.count;i++){
        CGRect imgFrame=CGRectMake(frame.size.width* i, 0, frame.size.width , frame.size.height);
        UIImageView* imgView=[[UIImageView alloc]initWithFrame:imgFrame];
        imgView.backgroundColor=self.imgArray[i];
        [self.scrollView addSubview:imgView];
    }
    
    self.scrollView.contentSize=CGSizeMake(frame.size.width * self.imgArray.count, frame.size.height);
    self.scrollView.pagingEnabled=YES;
    
    self.scrollView.contentOffset=CGPointMake(frame.size.width, 0);
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
    self.pageControl.numberOfPages=array.count;
    self.pageControl.currentPage=0;
    self.pageControl.tintColor=[UIColor whiteColor];
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    return self;
}
-(void)scrollImage{
            
    NSInteger page=[self.pageControl currentPage];
    page++;
    CGFloat offsetX= page * self.scrollView.frame.size.width+self.scrollView.frame.size.width;
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    offsetX+=scrollView.frame.size.width*0.5;
    
    //因为最前面还有一个imgView
    int page=offsetX/scrollView.frame.size.width-1;
    
    self.pageControl.currentPage=page;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer=nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    //优先级 设置到当前的runloop中
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        //[change objectForKey:NSKeyValueChangeNewKey] 是一个对象
        CGPoint offset= [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        if(offset.x >= self.scrollView.contentSize.width-self.scrollView.frame.size.width){
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
            self.pageControl.currentPage=0;
        }else if(offset.x <= 0){
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width-2*self.scrollView.frame.size.width, 0)];
            self.pageControl.currentPage=self.pageControl.numberOfPages-1;
        }
    }
}


@end
