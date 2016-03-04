//
//  CountCollectionViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "CountCollectionViewCell.h"

@interface CountCollectionViewCell ()

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation CountCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        
        self.countLabel = [[UILabel alloc] initFullInSuperview:self.contentView];;
        self.countLabel.font = FONT_OF_SIZE(10);
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.layer.borderWidth = SCREEN_SCALE/2;
        self.countLabel.layer.borderColor = C_LIGHT_GRAY.CGColor;
    }
    return self;
}


+ (NSString *)reuseIdentifier
{
    return @"CountCollectionViewCell";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.countLabel centerInSuperview];
}

- (void)setValue:(NSInteger)value{
    _value = value;
    self.countLabel.text = string(@"%d", value);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        self.countLabel.font = FEATURE_FONT_OF_SIZE(10);
        self.countLabel.layer.borderWidth = 2;
        self.countLabel.textColor = C_WHITE;
    }
    else{
        self.countLabel.font = FONT_OF_SIZE(10);
        self.countLabel.layer.borderWidth = SCREEN_SCALE/2;
        self.countLabel.textColor = C_BLACK;
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if(isSelected){
        self.countLabel.font = FEATURE_FONT_OF_SIZE(10);
        self.countLabel.layer.borderWidth = 2;
        self.countLabel.textColor = C_WHITE;
    }
    else{
        self.countLabel.font = FONT_OF_SIZE(10);
        self.countLabel.layer.borderWidth = SCREEN_SCALE/2;
        self.countLabel.textColor = C_BLACK;
    }
}

@end
