//
//  CashLabel.m
//  ABFOB
//
//  Created by Zac Adams on 1/03/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "CashLabel.h"

@implementation CashLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.font = TITLE_FONT_OF_SIZE(20);
        self.text = @"$";
    }
    return self;
}


@end
