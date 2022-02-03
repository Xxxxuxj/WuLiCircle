//
//  SectionFlowLayout.m
//  WuLi
//
//  Created by Mac on 2021/11/27.
//

#import "SectionFlowLayout.h"

@interface SectionFlowLayout()

// 保存section每一列的最大的Y值，然后获取到最短的一列，将下一个cell放在该列中。
@property (nonatomic, strong) NSMutableArray *maxYOfColumns;
// 保存所有cell的位置信息
@property (nonatomic, strong) NSMutableArray *layoutAttributes;
// 保存collectionView的bouns的高度。
@property (nonatomic, assign) CGFloat contentHeight;

@end



@implementation SectionFlowLayout

- (void)prepareLayout {
[super prepareLayout];

// 没有代理，没法布局。
if (_flowDelegate == nil) {
    NSLog(@"需要代理");
    
    return;
}

// 重新赋值，清除上一次计算的数据。
_contentHeight = self.contentInset.top;
_layoutAttributes = [NSMutableArray new];

// 使用delegate获取section的数量
NSInteger numberOfSection = [_flowDelegate numberOfSection];

for (int section = 0; section < numberOfSection; section++) {
    NSMutableArray *sectionLayoutAttributes = [self computeLayoutAttributesInSection:section];
    [_layoutAttributes addObjectsFromArray:sectionLayoutAttributes];
}
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
// 返回每个cell的位置信息等
NSInteger section = indexPath.section;
NSArray *sectionLayoutAttributes = _layoutAttributes[section];

return sectionLayoutAttributes[indexPath.row];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
return _layoutAttributes;
}

- (CGSize)collectionViewContentSize {
// 返回collectionView滑动的大小，因为横向没有滑动，X值不重要，也可以返回0
return CGSizeMake(0.0, _contentHeight + self.contentInset.bottom);
}

/**
 计算每个section的位置信息

 @param section section
 @return 与位置相关的信息。
 */
- (NSMutableArray *)computeLayoutAttributesInSection:(NSInteger)section {
// 获取section的列数和cell的个数
    NSInteger column = [_flowDelegate numberOfColumnInSectionAtIndex:section];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];

    NSMutableArray *attributesArr = [NSMutableArray new];
    CGFloat itemSpace = 0.0;
    CGFloat lineSpace = 0.0;
    UIEdgeInsets sectionInset;

    // 获取间距等信息，下面计算位置时需要用到
    // 因为是可选的实现方法，在直接使用时需要判断是否已经实现了。
    if ([_flowDelegate respondsToSelector:@selector(contentInsetOfSectionAtIndex:)]) {
        sectionInset = [_flowDelegate contentInsetOfSectionAtIndex:section];
    }

    if ([_flowDelegate respondsToSelector:@selector(minimumLineSpacingForSectionAtIndex:)]) {
        itemSpace = [_flowDelegate minimumInteritemSpacingForSectionAtIndex:section];
    }

    if ([_flowDelegate respondsToSelector:@selector(minimumLineSpacingForSectionAtIndex:)]) {
        lineSpace = [_flowDelegate minimumLineSpacingForSectionAtIndex:section];
    }

    // 留出每个section的顶部与上一个section的距离
    _contentHeight += sectionInset.top;

    if (column == 1) {
        // 一列，cell会占满屏幕
        for (int index = 0; index < itemCount; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
            
            // 获取cell的大小
            CGSize size = [_flowDelegate sizeForItemAtIndexPath:indexPath];
            
            // 为了让collectionView.contentInset和sectionInset有效果，需要将width减去这个两个inset的左右的数值
            attributes.frame = CGRectMake(self.contentInset.left + sectionInset.left, _contentHeight, size.width - self.contentInset.left - self.contentInset.right - sectionInset.left - sectionInset.right, size.height);
            
            [attributesArr addObject:attributes];
            
            // 保存下一个cell的Y轴的数值
            _contentHeight += attributes.size.height + lineSpace;
        }
        
        // 减去最后一行底部添加的lineSpace
        _contentHeight += (sectionInset.bottom - lineSpace);
        
        return attributesArr;
    }

    // 不止一列时
    // 保存每一个最后一个Cell的底部Y轴的数值
    _maxYOfColumns = [NSMutableArray new];

    for (int i = 0; i < column; i++) {
        self.maxYOfColumns[i] = @(0);
    }

    CGSize size;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    NSInteger currentColumn = 0;
    CGFloat width = 0.0;

    for (int index = 0; index < itemCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
        size = [_flowDelegate sizeForItemAtIndexPath:indexPath];
        
        if (index < column) {
            // 第一行直接添加到当前的列
            currentColumn = index;
            
        } else {// 其他行添加到最短的那一列
            // 这里使用!会得到期望的值
            NSNumber *minMaxY = [_maxYOfColumns valueForKeyPath:@"@min.self"];
            currentColumn = [_maxYOfColumns indexOfObject:minMaxY];
        }
        
        // 根据列数计算出每个cell的宽度
        width = (self.collectionView.bounds.size.width - itemSpace * (column - 1) - self.contentInset.left - self.contentInset.right - sectionInset.left - sectionInset.right) / column;
        
        // 根据将cell放在那一列，来计算出x坐标
        x = self.contentInset.left + sectionInset.left + currentColumn * (width + itemSpace);
        // 每个cell的y坐标
        y = lineSpace + [_maxYOfColumns[currentColumn] floatValue];
        
        // 记录每一列的最后一个cell的最大Y
        _maxYOfColumns[currentColumn] = @(y + size.height);

        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
        
        // 设置用于瀑布流效果的attributes的frame
        attributes.frame = CGRectMake(x, y + _contentHeight, width, size.height);
        
        [attributesArr addObject:attributes];
    }

    // 将所有列最大的Y值作为整个collectionView.cententSize的高度
    CGFloat maxY = [[_maxYOfColumns valueForKeyPath:@"@max.self"] floatValue];
    _contentHeight += maxY + sectionInset.bottom;

    return attributesArr;
}



@end
