//
//  NSDate+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SECONDS_IN_MINUTE   (60.0)
#define SECONDS_IN_HOUR     (3600.0)
#define SECONDS_IN_DAY      (86400.0)
#define SECONDS_IN_WEEK     (604800.0)
#define MINUTES_IN_HOUR     (60.0)
#define HOURS_IN_DAY        (24.0)
#define DAYS_IN_WEEK        (7.0)

@interface NSDate (Roam)

@property (nonatomic, readonly) NSInteger utcYear;
@property (nonatomic, readonly) NSInteger utcMonth;
@property (nonatomic, readonly) NSInteger utcDay;
@property (nonatomic, readonly) NSInteger utcHour;
@property (nonatomic, readonly) NSInteger utcMinute;
@property (nonatomic, readonly) NSInteger utcSecond;

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;

- (NSDate *)dateByAddingSeconds:(NSInteger)numSeconds;
- (NSDate *)dateByAddingMinutes:(NSInteger)numMinutes;
- (NSDate *)dateByAddingHours:(NSInteger)numHours;
- (NSDate *)dateByAddingDays:(NSInteger)numDays;
- (NSDate *)dateByAddingWeeks:(NSInteger)numWeeks;
- (NSDate *)dateByAddingMonths:(NSInteger)numMonths;
- (NSDate *)dateByAddingYears:(NSInteger)numYears;

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDatePattern:(NSString *)datePattern;
- (NSString *)formattedDatePattern:(NSString *)datePattern timeZone:(NSTimeZone *)timeZone;

- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedUTCTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDatePattern:(NSString *)datePattern;

- (NSDate *)dateAsMidnight;

@end
