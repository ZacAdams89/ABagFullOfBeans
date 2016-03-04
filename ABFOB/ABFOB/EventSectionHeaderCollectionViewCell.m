//
//  EventSectionHeaderCollectionViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 4/03/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventSectionHeaderCollectionViewCell.h"

@interface EventSectionHeaderCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation EventSectionHeaderCollectionViewCell

+ (NSString *)reuseIdentifier{
    return @"EventSectionHeaderCollectionViewCell";
}

+ (CGSize)cellSize{
    if(IS_PAD)
        return s(375, 100);
    else
        return s([[[UIApplication sharedApplication] delegate] window].frame.size.width, 100);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.titleLabel = [[UILabel alloc] initFullInSuperview:self.contentView];
        self.titleLabel.font = FONT_OF_SIZE(11);
        self.titleLabel.text = @"Header";
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
