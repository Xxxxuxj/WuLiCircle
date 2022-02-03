//
//  LocationView.m
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import "LocationView.h"
@interface LocationView() <UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL loadData;
}
@end



@implementation LocationView

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadDataToShow) name:@"loadDataToShow" object:nil];
        loadData=NO;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=10;
    layout.itemSize=CGSizeMake(self.frame.size.width-20, 200);
    layout.sectionInset=UIEdgeInsetsMake(5, 0, 5, 0);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
    
    for(int i=0;i<100;i++){
    [self.collectionView registerClass:[LocationCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%d",i]];
    }
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.recommendArray) return self.recommendArray.count;
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LocationCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.item] forIndexPath:indexPath];
    if(loadData){
        [cell layoutWithModel:self.recommendArray[indexPath.item]];
    }
    return cell;
}

-(void)loadDataToShow{
    loadData=YES;
    self.recommendArray=[[NSMutableArray alloc]init];
    self.commodityIdArray=[[NSMutableArray alloc]init];
    [GetCommodityOrCircle getCommodityForCount:10 WithLocation:@"南湖" ForUser:[UserDefaults getUser].userId resultOfGetBlock:^(BOOL isSuccessful, NSArray * _Nonnull array) {
        if(isSuccessful){
            self.recommendArray=[array valueForKey:@"dataDic"];
            self.commodityIdArray=[array valueForKey:@"objectId"];
            [self.collectionView reloadData];
        }
    }];
    
}


@end
