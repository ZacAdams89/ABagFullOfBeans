//
//  CollectionHeaderCollectionViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 16/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "CollectionHeaderCollectionViewCell.h"

@interface CollectionHeaderCollectionViewCell ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation CollectionHeaderCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.headerLabel = [[UILabel alloc] initFullInSuperview:self.contentView];
        self.headerLabel.font = FONT_OF_SIZE(15);
    }
    return self;
}

+ (NSString *)reuseIdentifier
{
    return @"CollectionHeaderCollectionViewCell";
}

+ (CGSize)cellSize{
    if(IS_PAD)
        return s(375, 40);
    else
        return s([[[UIApplication sharedApplication] delegate] window].frame.size.width, 40);
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.headerLabel.text = title;
}

@end
