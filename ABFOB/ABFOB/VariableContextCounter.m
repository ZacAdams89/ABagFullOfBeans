//
//  VariableContextCounter.m
//  ABFOB
//
//  Created by Zac Adams on 10/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "VariableContextCounter.h"
#import "CountSelectorView.h"

@interface VariableContextCounter ()<CountSelectorViewDelegate>


@property (nonatomic, strong) UILabel *contextTitle;
@property (nonatomic, strong) UISwitch *contextSwitch;
@property (nonatomic, strong) UILabel *contextCountTitle;
@property (nonatomic, strong) CountSelectorView *countSelector;

@end


@implementation VariableContextCounter


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.contextTitle = [[UILabel alloc] initInSuperview:self];
        self.contextTitle.textAlignment = NSTextAlignmentLeft;
        self.contextTitle.font = TITLE_FONT_OF_SIZE(20);
        self.contextTitle.text = @"Title";
        
        //
        self.contextSwitch = [[UISwitch alloc] initInSuperview:self];
        self.contextSwitch.on = NO;
        [self.contextSwitch addTarget:self action:@selector(switched) forControlEvents:UIControlEventValueChanged];
        
        //
        self.contextCountTitle = [[UILabel alloc] initInSuperview:self];
        self.contextCountTitle.font = SECONDARY_FONT_SIZE(15);
        self.contextCountTitle.textAlignment = NSTextAlignmentLeft;
        self.contextCountTitle.text = @"How many?";
        self.contextCountTitle.hidden = YES;
        
        //
        self.countSelector = [[CountSelectorView alloc] initInSuperview:self];
        self.countSelector.value = 0;
        self.countSelector.delegate = self;
        self.countSelector.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

    [self.contextTitle setEdge:UIViewEdgeTop length:25 insets:inset_left(20)];

    [self.contextSwitch setEdge:UIViewEdgeLeft size:s(100, 30) insets:i(self.contextTitle.bottom + 5, 0, 0, 20)];
    
    [self.contextCountTitle setEdge:UIViewEdgeLeft length:90 insets:i(self.contextSwitch.top, 0, 0, self.contextSwitch.right + 10)];
    self.contextCountTitle.centerY = self.contextSwitch.centerY;
    
    [self.countSelector setEdge:UIViewEdgeLeft length:130 insets:i(self.contextSwitch.top, 0, 0, self.contextCountTitle.right + 10)];
}

- (BOOL)contextOn{
    return self.contextSwitch.on;
}

- (NSInteger)value{
    return self.countSelector.value;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.contextTitle.text = title;
}


- (void)switched{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(variableContextCounter:didSwitchTo:)]){
        [self.delegate variableContextCounter:self didSwitchTo:self.contextSwitch.on];
    }
    
    
    self.contextCountTitle.hidden = !self.contextSwitch.on;
    self.countSelector.hidden = !self.contextSwitch.on;
}

#pragma mark - Counter delegate 

- (void)countSelectorView:(CountSelectorView *)countSelector didChangeValue:(NSInteger)value{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(variableContextCounter:didSelectValaue:)]){
        [self.delegate variableContextCounter:self didSelectValaue:value];
    }
}

@end
