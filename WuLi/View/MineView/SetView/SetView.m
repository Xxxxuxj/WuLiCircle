//
//  SetView.m
//  WuLi
//
//  Created by Mac on 2021/12/1.
//

#import "SetView.h"
@interface SetView() <UICollectionViewDelegate,UICollectionViewDataSource>

@end


@implementation SetView

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
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(self.frame.size.width-30, 50);
    layout.sectionInset=UIEdgeInsetsMake(0, 10, 10, 10);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
    
    [self.collectionView registerClass:[SetCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SetCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        [[UserStatus sharedInstance] exitUser];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"exitUser" object:nil];
    }
}


@end
