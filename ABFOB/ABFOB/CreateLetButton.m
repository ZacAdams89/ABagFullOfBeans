//
//  CreateLetButton.m
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "CreateLetButton.h"

@interface CreateLetButton ()

@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *verticleLine;

@end

@implementation CreateLetButton


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        self.horizontalLine = [[UIView alloc] initInSuperview:self];
        self.verticleLine = [[UIView alloc] initInSuperview:self];
        self.verticleLine.userInteractionEnabled = NO;
        self.horizontalLine.userInteractionEnabled = NO;
        
        self.horizontalLine.backgroundColor = C_WHITE;
        self.verticleLine.backgroundColor = C_WHITE;
        
        
        
        CGFloat inset = 10;
        
        self.horizontalLine.width = self.width - inset * 2;
        self.horizontalLine.height = 5;
        self.horizontalLine.center = p(self.width/2, self.height/2);
        
        self.verticleLine.width = 5;
        self.verticleLine.height = self.height - inset * 2;
        self.verticleLine.center = p(self.width/2, self.height/2);
        
        
        self.layer.cornerRadius = self.height / 2;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.horizontalLine centerInSuperview];
    [self.verticleLine centerInSuperview];
    
}


@end
