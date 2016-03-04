//
//  UIView+Animation.m
//  IMeasureU
//
//  Created by Zac Adams on 17/09/14.
//  Copyright (c) 2014 RoamLtd. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)


- (void)shake{
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *center = [NSValue valueWithCGPoint:self.center];
    NSValue *left = [NSValue valueWithCGPoint:CGPointMake(self.center.x - 7.0, self.center.y)];
    NSValue *right = [NSValue valueWithCGPoint:CGPointMake(self.center.x + 7.0, self.center.y)];
    
    shakeAnimation.values = @[center, left, center, right, center, left, center, right, center];
    
    shakeAnimation.duration = 0.3f;
    
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:shakeAnimation forKey:nil];
}


- (void)spin{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 3.0; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.layer addAnimation:rotation forKey:@"Spin"];
}

- (void)spinAndBounce{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 3.0; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.layer addAnimation:rotation forKey:@"Spin"];
    
    CABasicAnimation *bounce;
    bounce = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bounce.autoreverses = YES;
    bounce.fromValue = [NSNumber numberWithFloat:self.scale];
    bounce.toValue = [NSNumber numberWithFloat:(self.scale + 0.2f)];
    bounce.duration = 1.0; // Speed
    bounce.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.layer addAnimation:bounce forKey:@"Bounce"];
}

- (void)flash
{
    CABasicAnimation *flash;
    flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.autoreverses = YES;
    flash.fromValue = @1.0f;
    flash.toValue = @0.0f;
    flash.duration = 0.3; // Speed
    flash.repeatCount = 1; // Repeat forever. Can be a finite number.
    [self.layer addAnimation:flash forKey:@"flash"];
}

- (void)flashFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    [self flash];
    
    
    
    CABasicAnimation *flash;
    flash = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    flash.autoreverses = YES;
    flash.fromValue = (id)fromColor.CGColor;
    flash.toValue = (id)toColor.CGColor;
    flash.duration = 0.5; // Speed
    flash.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.layer addAnimation:flash forKey:@"flashColor"];

    
}

- (void)stopAnimating{
    [self.layer removeAllAnimations];
}


- (void)jiggle{
    

    const CGFloat kAnimationRotateDeg = 0.5;
    const CGFloat kAnimationTranslateX = 1.0;
    const CGFloat kAnimationTranslateY = 1.0;
    
    int count = 1;
    CGAffineTransform leftWobble = CGAffineTransformMakeRotation(RADIANS( kAnimationRotateDeg * (count%2 ? +1 : -1 ) ));
    CGAffineTransform rightWobble = CGAffineTransformMakeRotation(RADIANS( kAnimationRotateDeg * (count%2 ? -1 : +1 ) ));
    CGAffineTransform moveTransform = CGAffineTransformTranslate(rightWobble, -kAnimationTranslateX, -kAnimationTranslateY);
    CGAffineTransform conCatTransform = CGAffineTransformConcat(rightWobble, moveTransform);
    
    self.transform = leftWobble;  // starting point
    
    [UIView animateWithDuration:0.1
                          delay:(count * 0.08)
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{ self.transform = conCatTransform; }
                     completion:nil];
    
}




@end
