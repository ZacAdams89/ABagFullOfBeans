//
//  TagableView.m
//  ABFOB
//
//  Created by Zac Adams on 16/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "TagableView.h"

@interface TagableView ()

@property (nonatomic, strong) NSArray *tagLabels;
@property (nonatomic, strong) NSMutableArray *tags;

@end

@implementation TagableView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.tags = [NSMutableArray array];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self stackSubviewsAgainstEdge:UIViewEdgeLeft insets:i(5, 20, 5, 20) spacing:5];
}

- (void)clear
{
    // Remove all the tags
    [self.tags removeAllObjects];
    
    // Clear the labels
    for(UILabel *tagLabel in self.tagLabels){
        tagLabel.text = @"";
        tagLabel.hidden = YES;
    }
}

- (NSArray *)tagLabels{
    if(nil == _tagLabels){
        
        NSMutableArray *tags = [NSMutableArray arrayWithCapacity:3];
        [tags addObject:[self tagLabel]];
        [tags addObject:[self tagLabel]];
        [tags addObject:[self tagLabel]];
        _tagLabels = tags;
    }
    
    return _tagLabels;
}

- (void)addTag:(NSString *)tagTitle{
    
    // Avoid double ups in tags.
    if(NO == [self.tags containsObject:tagTitle]){
        
        UILabel *tagLabel = self.tagLabels[self.tags.count];
        tagLabel.text = tagTitle;
        tagLabel.hidden = NO;
        [self sizeTagToFit:tagLabel];
        [self.tags addObject:tagTitle];
        
        [self stackSubviewsAgainstEdge:UIViewEdgeLeft insets:i(5, 20, 5, 20) spacing:5];
    }
}

- (UILabel *)tagLabel{

    
    UILabel *tagLabel = [[UILabel alloc] initInSuperview:self];
    tagLabel.text = @"tag";
    [self sizeTagToFit:tagLabel];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.backgroundColor = C_LIGHT_GRAY;
    tagLabel.textColor = C_BLACK;
    tagLabel.layer.cornerRadius = 5;
    tagLabel.clipsToBounds = YES;
    tagLabel.font = FONT_OF_SIZE(10);
    tagLabel.hidden = YES;
    
    return tagLabel;
}

- (void)sizeTagToFit:(UILabel *)tagLabel{
    
    const CGFloat kTagEdgeMargin = 2;
    [tagLabel sizeToFit];
    tagLabel.width += kTagEdgeMargin *2;
    tagLabel.height = self.height;
}


@end
