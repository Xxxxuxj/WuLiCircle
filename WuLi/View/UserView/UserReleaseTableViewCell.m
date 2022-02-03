//
//  UserReleaseTableViewCell.m
//  WuLi
//
//  Created by Mac on 2022/1/23.
//

#import "UserReleaseTableViewCell.h"
@interface UserReleaseTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,SectionFlowLayoutDelegate>
{
    NSMutableArray  *commodityArray;
    NSMutableArray  *commodityHeightArray;
    NSMutableArray  *circleArray;
    NSMutableArray  *circleHeightArray;

}
@end
static CGFloat Width;
static CGFloat Height;
@implementation UserReleaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc{
    NSLog(@"%@",self);
    [self.commodityCollectionView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        commodityHeightArray    =[[NSMutableArray alloc]init];
        commodityArray          =[[NSMutableArray alloc]init];
        circleHeightArray       =[[NSMutableArray alloc]init];
        circleArray             =[[NSMutableArray alloc]init];
        Width=[UIScreen mainScreen].bounds.size.width;
        Height=[UIScreen mainScreen].bounds.size.height;
    }
    return self;
}

-(void)layoutWithUserID:(NSString *)ID{
    [GetCommodityOrCircle getUserCommodity:ID resultOfGetBlock:^(BOOL isSuccessful, NSMutableArray * _Nonnull cArray) {
        if(isSuccessful){
            self->commodityArray=cArray;
            SDImageCache *cache=[SDImageCache sharedImageCache];
            for(BmobObject *bmob in self->commodityArray){
                NSString *str=[bmob objectForKey:@"firstPicUrl-C"];
                NSURL *url=[NSURL URLWithString:str];
                NSData  *data=[NSData dataWithContentsOfURL:url];
                UIImage *image=[UIImage imageWithData:data];
                [cache storeImage:image forKey:str toDisk:YES completion:nil];
                CGSize size=CGSizeMake(Width/2-20, ((Width/2-20)/image.size.width )*image.size.height+60);
                [self->commodityHeightArray addObject:[NSValue valueWithCGSize:size]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI];
            });
        }
    }];
}


-(void)setUI{
    
    SectionFlowLayout *sectionLayout=[[SectionFlowLayout alloc]init];
    sectionLayout.flowDelegate=self;
    self.commodityCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, Height-80) collectionViewLayout:sectionLayout];
    [self.commodityCollectionView registerClass:[UserCommodityCollectionViewCell class] forCellWithReuseIdentifier:@"commoditycell"];
    self.commodityCollectionView.delegate=self;
    self.commodityCollectionView.dataSource=self;
    //self.commodityCollectionView.bounces=NO;
    self.commodityCollectionView.showsVerticalScrollIndicator=NO;
    [self.commodityCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.scrollView.contentSize=CGSizeMake(self.bounds.size.width*2, self.bounds.size.height);
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    [self.scrollView addSubview:self.commodityCollectionView];
    
    [self addSubview:self.scrollView];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if([collectionView isEqual:self.commodityCollectionView]){
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([collectionView isEqual:self.commodityCollectionView]){
        return commodityArray.count;
    }else{
        return circleArray.count;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.commodityCollectionView]){
        UserCommodityCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"commoditycell" forIndexPath:indexPath];
        [cell layoutWithBmobObject:commodityArray[indexPath.item]];
        return cell;
    }else{
        UserCircleCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"circlecell" forIndexPath:indexPath];
        return cell;
    }
}

- (NSInteger)numberOfSection {
    return [self numberOfSectionsInCollectionView:_commodityCollectionView];
}

- (NSInteger)numberOfColumnInSectionAtIndex:(NSInteger)section {
    return 2;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@",commodityHeightArray[indexPath.item]);
    return [commodityHeightArray[indexPath.item] CGSizeValue];
        
}

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)contentInsetOfSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5,5);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint offset=[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    if(offset.y<=150 && offset.y>=0){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setContentOffset" object:nil userInfo:@{@"offset":[change valueForKey:NSKeyValueChangeNewKey]}];
        NSLog(@"%f",offset.y);
    }
}

@end
