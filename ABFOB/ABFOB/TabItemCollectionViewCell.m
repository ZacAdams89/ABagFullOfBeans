//
//  TabItemView.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 14/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "TabItemCollectionViewCell.h"

const CGFloat kPadTabItemCellHeight = 50.0;
const CGFloat kPadTabItemCellWidth = 50.0;
const CGFloat kPhoneTabItemCellHeight = 50.0;
const CGFloat kPhoneTabItemCellWidth = 50.0;


#define SELETED_FONT TITLE_FONT_OF_SIZE(10)
#define UNSELECTED_FONT FONT_OF_SIZE(10)

@interface TabItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tabTitleLabel;

@end

@implementation TabItemCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        
        // Image
        self.imageView = [[UIImageView alloc] initCenterInSuperview:self.contentView size:[self.class cellSize] insets:inset_bottom(20)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.tintColor = C_FADED;
        
        
        // Title
        self.tabTitleLabel = [[UILabel alloc] initInSuperview:self.contentView edge:UIViewEdgeBottom length:20];
        self.tabTitleLabel.font = UNSELECTED_FONT;
        self.tabTitleLabel.textColor = C_FADED;
        self.tabTitleLabel.text = @"Title";
        self.tabTitleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
 
    [self.imageView fillInsets:inset_bottom(20)];
    [self.tabTitleLabel setEdge:UIViewEdgeBottom length:20];
    
}


+ (CGSize)cellSize
{
    if(IS_PAD){
        return s(kPadTabItemCellWidth, kPadTabItemCellHeight);
    }
    else{
        return s(kPhoneTabItemCellWidth, kPadTabItemCellHeight);
    }
}


+ (NSString *)reuseIdentifier{
    return @"TabItemCollectionViewCell";
}


- (void)setTabItem:(TabItem *)tabItem{
    _tabItem = tabItem;
    self.tabTitleLabel.text = tabItem.title;
    self.imageView.image = tabItem.icon;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if(selected) {
        self.tabTitleLabel.textColor = C_SELECTED;
        self.tabTitleLabel.tintColor = C_SELECTED;
        self.tabTitleLabel.font = SELETED_FONT;
        self.imageView.tintColor = C_SELECTED;
        self.imageView.image = self.tabItem.selectedIcon;
    }
    else{
        self.tabTitleLabel.textColor = C_FADED;
        self.tabTitleLabel.tintColor = C_FADED;
        self.tabTitleLabel.font = UNSELECTED_FONT;
        self.imageView.tintColor = C_FADED;
        self.imageView.image = self.tabItem.icon;
    }
    
}

@end
