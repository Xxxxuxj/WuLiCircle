//
//  HomeView.m
//  WuLi
//
//  Created by Mac on 2021/12/5.
//

#import "HomeView.h"
@interface HomeView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end



@implementation HomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setHomeViewContentOffset:) name:@"setHomeViewContentOffset" object:nil];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.labelScrollView=[[LabelScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    
    self.homeScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
    self.homeScrollView.pagingEnabled=YES;
    self.homeScrollView.contentSize=CGSizeMake(self.frame.size.width*10, self.frame.size.height-30);
    self.homeScrollView.showsVerticalScrollIndicator=NO;
    self.homeScrollView.showsHorizontalScrollIndicator=NO;
    [self.homeScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
    

    
    
    
    [self addSubview:self.homeProgressView];
    [self addSubview:self.homeScrollView];
    [self addSubview:self.labelScrollView];
}



-(void)layoutWithModelArray:(NSArray *)modelArray{
    
    
    
    self.modelArray=modelArray;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset=UIEdgeInsetsMake(0, 10, 20, 10);
    
    
    self.collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
    [self.collection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    //[self.collection registerClass:[headerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid"];
    
    
    
    self.collection.delegate=self;
    self.collection.dataSource=self;
    [self.homeScrollView addSubview:self.collection];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"homeScrollViewChanged" object:nil userInfo:change];
        
            
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)setHomeViewContentOffset:(NSNotification *)notification{
    int index=[[notification.userInfo valueForKey:@"index"] intValue];
    
    [self.homeScrollView setContentOffset:CGPointMake(index*self.bounds.size.width, 0) ];
}






#pragma mark -


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleModel *model=[self.modelArray objectAtIndex:indexPath.item];
    if(model.picArray.count==0){
        return CGSizeMake(self.frame.size.width-20, 130);
    }else{
        return CGSizeMake(self.frame.size.width-20, 220);
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell layoutWithCircleModel:[self.modelArray objectAtIndex:indexPath.item]];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(self.frame.size.width, 40);
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionReusableView *headerView=nil;
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
//        headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid" forIndexPath:indexPath];
//    }
//    return headerView;
//}


@end
