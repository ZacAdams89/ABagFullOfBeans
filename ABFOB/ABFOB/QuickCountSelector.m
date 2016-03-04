//
//  QuickCountSelector.m
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "QuickCountSelector.h"
#import "CountCollectionViewCell.h"

@interface QuickCountSelector ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *countCollectionView;

@end

@implementation QuickCountSelector


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = s(50, 50);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 10;
        
        self.countCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.countCollectionView registerClass:[CountCollectionViewCell class] forCellWithReuseIdentifier:[CountCollectionViewCell reuseIdentifier]];
        [self addSubview:self.countCollectionView];
        self.countCollectionView.delegate = self;
        self.countCollectionView.dataSource = self;
        self.countCollectionView.backgroundColor = C_CLEAR;
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.countCollectionView fill];
    [self.countCollectionView reloadData];
    
            self.countCollectionView.allowsMultipleSelection = NO;
}

- (void)setValue:(NSInteger)value{
    _value = value;
    [self.countCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:value -1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


/// Unselect all cells
- (void)clear{
    NSArray *selectedIndices = [self.countCollectionView indexPathsForSelectedItems];
    for(NSIndexPath *path in selectedIndices){
        [self.countCollectionView deselectItemAtIndexPath:path animated:YES];
    }

}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CountCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CountCollectionViewCell *countCell = (CountCollectionViewCell *)cell;
    countCell.value = indexPath.item + 1;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(quickCountSelector:didSelectCount:)]){
        [self.delegate quickCountSelector:self didSelectCount:indexPath.item+1];
    }
    
//    CountCollectionViewCell *cell = (CountCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
//    CountCollectionViewCell *cell = (CountCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.isSelected = NO;
//    [cell setSelected:NO];
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view =  [super hitTest:point withEvent:event];
    if(view == nil){
        return self;
    }
    else{
        return view;
    }
}

@end
