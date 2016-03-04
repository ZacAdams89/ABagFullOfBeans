//
//  EventsLetsTableViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventsLetsTableViewCell.h"
#import "LetCollectionViewCell.h"

@interface EventsLetsTableViewCell ()<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *letCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayoutFlow;

@end

@implementation EventsLetsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        const float kScreenWidth = [[[UIApplication sharedApplication] delegate] window].bounds.size.width;
        self.letCollectionView = [[UICollectionView alloc] initWithFrame:r(0, 0, kScreenWidth, 0) collectionViewLayout:self.collectionLayoutFlow];
        self.letCollectionView.backgroundColor = C_CLEAR;
        self.letCollectionView.dataSource = self;
        [self.contentView addSubview:self.letCollectionView];
        [self.letCollectionView registerClass:[LetCollectionViewCell class] forCellWithReuseIdentifier:[LetCollectionViewCell reuseIdentifier]];
        self.letCollectionView.scrollEnabled = NO;

    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return @"EventsLetsTableViewCell";
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.letCollectionView fill];
}

- (void)setLets:(NSArray *)lets{
    _lets = lets;
    self.letCollectionView.height = lets.count * [LetCollectionViewCell cellSize].height;
    self.letCollectionView.contentSize = self.letCollectionView.size;
    [self.letCollectionView reloadData];
}

- (double)contentHeight{
    return self.letCollectionView.contentSize.height;
}


- (UICollectionViewFlowLayout *)collectionLayoutFlow{
    
    if(nil == _collectionLayoutFlow){
        _collectionLayoutFlow = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayoutFlow.itemSize = [LetCollectionViewCell cellSize];
        _collectionLayoutFlow.minimumInteritemSpacing = 10;
        
        if(IS_PAD){
            _collectionLayoutFlow.minimumLineSpacing = 10;
        }
        else{
            _collectionLayoutFlow.minimumLineSpacing = 0l;
        }
    }
    
    return _collectionLayoutFlow;
}


#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.lets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LetCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LetCollectionViewCell *letCell = (LetCollectionViewCell *)cell;
    letCell.let = self.lets[indexPath.item];
}

@end
