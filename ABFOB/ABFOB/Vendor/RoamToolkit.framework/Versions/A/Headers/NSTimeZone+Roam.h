//
//  NSTimeZone+NSTimeZone_Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimeZone (Roam)

- (CGFloat)secondsBetweenTimezone:(NSTimeZone *)timeZone;
- (CGFloat)minutesBetweenTimezone:(NSTimeZone *)timeZone;
- (CGFloat)hoursBetweenTimezone:(NSTimeZone *)timeZone;

@end
