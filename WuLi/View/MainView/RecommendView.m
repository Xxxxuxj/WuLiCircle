//
//  RecommandView.m
//  WuLi
//
//  Created by Mac on 2021/11/26.
//

#import "RecommendView.h"

@interface RecommendView() <UICollectionViewDelegate,UICollectionViewDataSource,SectionFlowLayoutDelegate>
// 用来存放Cell的唯一标示符
@property (nonatomic, strong) NSMutableDictionary *cellDic;


@end

static CGFloat Width;
static CGFloat Height;

@implementation RecommendView

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
        
        Width=self.frame.size.width;
        Height=self.frame.size.height;
        
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRecommendArray:) name:@"getRecommendArray" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recommendViewReloadData:) name:@"recommendViewReloadData" object:nil];
        

        self.cellDic = [[NSMutableDictionary alloc] init];
        _commodityHeightArray=[[NSMutableArray alloc]init];
        _recommendArray=[[NSMutableArray alloc]init];
        _recommendArray=(NSMutableArray *)[GetCommodityOrCircle getCommodityForCount:10 ForUser:[UserDefaults getUser].userId];
        
        }
        
        
        
        _roundImageArray=[NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor yellowColor],[UIColor blueColor], [UIColor greenColor],nil];
        [self setUI];

    return self;

}

-(void)setUI{
    
    SectionFlowLayout* layout=[[SectionFlowLayout alloc]init];
    layout.contentInset=UIEdgeInsetsMake(5, 10, 5, 10);
    layout.flowDelegate=self;
    
    self.commodityCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self.commodityCollectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.commodityCollectionView registerClass:[RoundCollectionViewCell class] forCellWithReuseIdentifier:@"roundCell"];
    
    self.commodityCollectionView.delegate=self;
    self.commodityCollectionView.dataSource=self;
    self.commodityCollectionView.showsHorizontalScrollIndicator=FALSE;
    self.commodityCollectionView.showsVerticalScrollIndicator=FALSE;
    [self addSubview:self.commodityCollectionView];
}



-(void)getRecommendArray:(NSNotification *)notification{
    self.recommendArray=[[notification.userInfo valueForKey:@"array"] valueForKey:@"dataDic"];
    self.commodityIdArray=[[notification.userInfo valueForKey:@"array"] valueForKey:@"objectId"];
    
    dispatch_queue_t queue=dispatch_queue_create("getRecommend", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for(id model in self.recommendArray){
            NSURL *url=[NSURL URLWithString:[[model valueForKey:@"picArray"] firstObject] ];
            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

            CGSize size=CGSizeMake(Width/2-20, ((Width/2-20)/image.size.width )*image.size.height+60);
            [self->_commodityHeightArray addObject:[NSValue valueWithCGSize:size]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commodityCollectionView reloadData];
        });
    }
    );
}






- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    return self.recommendArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CommodityModel *model=[CommodityModel new];
    [model configWithDic:[self.recommendArray objectAtIndex:indexPath.item]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushDetailViewController" object:nil userInfo:@{@"model":model}];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        RoundCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"roundCell" forIndexPath:indexPath];
        [cell layoutWithImageArray:self.roundImageArray];
        return cell;
    }else{
#pragma mark 性能优化点
        //uicollectionview的cell重用会导致布局混乱 所以不重用 对性能有很大影响
        NSString *identifier = [self.cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        if (identifier == nil) {
            identifier = [NSString stringWithFormat:@"NewTravelMediaCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [self.cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell***************这里一定要注意一个问题，那就是你的cell 有没有用xib创建
            // 如果你是代码写的cell那么注册用下面的方法
            [collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        }
        
        RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        // 这样出来的cell 他的标识都是唯一的。所以解决了复用会出错的问题。
        //RecommendCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//        dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(queue, ^{
//            [cell layoutWithModel:self->_recommendArray[indexPath.item]];
//        });
        if(_recommendArray[indexPath.item]){
            [cell layoutWithModel:_recommendArray[indexPath.item]];
        }
        return cell;
    }
}


- (NSInteger)numberOfSection {
    return [self numberOfSectionsInCollectionView:_commodityCollectionView];
}

- (NSInteger)numberOfColumnInSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        if(indexPath.section==0){
            return CGSizeMake(self.frame.size.width, 200);
        }else{
            
            
            return [self.commodityHeightArray[indexPath.item] CGSizeValue];
        }
}

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(section==0) return 0;
    return 10;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(section==0) return 0;
    return 10;
}

- (UIEdgeInsets)contentInsetOfSectionAtIndex:(NSInteger)section {
    if(section==0) return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(5, 5, 5,5);
}


-(void)recommendViewReloadData:(NSNotification *)notification{
    
}



@end
