//
//  CountSelectorView.m
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "CountSelectorView.h"

@interface CountSelectorView ()

@property (nonatomic, strong) UIButton *incrementButton;
@property (nonatomic, strong) UIButton *decrementButton;
@property (nonatomic, strong) UILabel *valueLable;


@end

@implementation CountSelectorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.decrementButton = [[UIButton alloc] initInSuperview:self];
        [self styleButton:self.decrementButton];
        [self.decrementButton addTarget:self action:@selector(decrementValue)];
        [self.decrementButton setTitle:@"-" forState:UIControlStateNormal];
        

        self.valueLable = [[UILabel alloc] initInSuperview:self];
//        self.valueLable.textColor = C_PRIMARY;
        self.valueLable.textAlignment = NSTextAlignmentCenter;
        self.valueLable.font = FONT_OF_SIZE(10);
        self.valueLable.layer.borderWidth = SCREEN_SCALE/2;
        self.valueLable.layer.borderColor = C_LIGHT_GRAY.CGColor;
        
        // Increment
        self.incrementButton = [[UIButton alloc] initInSuperview:self];
        [self styleButton:self.incrementButton];
        [self.incrementButton addTarget:self action:@selector(incrementValue)];
        [self.incrementButton setTitle:@"+" forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    const CGFloat kSpacing = 5;
    const CGFloat kWidth = (self.width - (3* kSpacing)) / 3;
    self.incrementButton.size = s(kWidth, self.height);
    self.decrementButton.size = s(kWidth, self.height);
    self.valueLable.size = s(kWidth, self.height);
    [self stackSubviewsAgainstEdge:UIViewEdgeLeft insets:CGInsetsZero spacing:kSpacing];
}

- (void)styleButton:(UIButton *)button{
    
    [button setTitleColor:C_BLACK forState:UIControlStateNormal];
    button.layer.borderColor = C_LIGHT_GRAY.CGColor;
    button.layer.borderWidth = SCREEN_SCALE/2;
}


- (void)setValue:(NSInteger)value{
    _value = value;
    
    if(_value < 1){
        _value = 1;
        self.decrementButton.enabled = NO;
    }
    else if(_value == 1){
        self.decrementButton.enabled = NO;
    }
    
    self.valueLable.text = string(@"%d", value);
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(countSelectorView:didChangeValue:)]){
        [self.delegate countSelectorView:self didChangeValue:value];
    }
}


- (void)incrementValue{
    self.value++;
    if(self.value > 1){
        self.decrementButton.enabled = YES;
    }
}

- (void)decrementValue{
    self.value--;
    if(self.value <= 1){
        self.decrementButton.enabled = NO;
    }
}

@end
