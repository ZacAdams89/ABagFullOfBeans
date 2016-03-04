//
//  UIView+Animation.h
//  IMeasureU
//
//  Created by Zac Adams on 17/09/14.
//  Copyright (c) 2014 RoamLtd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)


- (void)shake;
- (void)spin;
- (void)spinAndBounce;
- (void)flash;
- (void)stopAnimating;
- (void)jiggle;
- (void)flashFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
