//
//  EventManager.m
//  ABFOB
//
//  Created by Zac Adams on 5/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventManager.h"

@interface EventManager ()

@property (nonatomic, strong) id<EventManagerDelegate> delegate;

@end


@implementation EventManager

@synthesize activeEvent;


- (void)setup{
    [self loadTodaysEvents];
    [self loadFutureEvents];
    [self loadPastEvents];
}

- (void)addDelegate:(id<EventManagerDelegate>)delegate{
    self.delegate = delegate;
}

- (NSDate *)morningStart{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:1];
    NSDate *morningStart = [calendar dateFromComponents:components];
    
    return morningStart;
}


- (NSDate *)tonightEnd{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    NSDate *tonightEnd = [calendar dateFromComponents:components];
    
    return tonightEnd;
}



- (BOOL)isTodaysEventValid{
    
    if(activeEvent){
        
        if([activeEvent.date timeIntervalSinceDate:[self tonightEnd]] > 0){
            // Event is over
            return NO;
        }
        else{
            // Negative time, event is still going
            return YES;
        }
        
    }
    
    return NO;
}

- (Event *)activeEvent{
    
    if(nil == activeEvent){
        PFQuery *query = [PFQuery queryWithClassName:[Event parseClassName]];
        [query includeKey:@"pricingModel"];
        [query whereKey:@"active"equalTo:@YES];
        NSArray *events = [query findObjects];
        activeEvent = [events firstObject];
        
    }
    
    return activeEvent;
}



- (void)loadTodaysEvents{

    PFQuery *query = [PFQuery queryWithClassName:[Event parseClassName]];
    [query includeKey:@"pricingModel"];
    [query whereKey:@"date" greaterThan:[self morningStart]];
    [query whereKey:@"date" lessThan:[self tonightEnd]];

    _todaysEvents = [query findObjects];

    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(eventManager:didLoadTodaysEvents:)]){
        [self.delegate eventManager:self didLoadTodaysEvents:self.todaysEvents];
    }
}


- (void)loadPastEvents{
    
    PFQuery *query = [PFQuery queryWithClassName:[Event parseClassName]];
    [query includeKey:@"pricingModel"];
    [query whereKey:@"date" lessThan:[self morningStart]];
    
    _pastEvents = [query findObjects];
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(eventManager:didLoadPastEvents:)]){
        [self.delegate eventManager:self didLoadPastEvents:self.pastEvents];
    }
}


- (void)loadFutureEvents{
    
    PFQuery *query = [PFQuery queryWithClassName:[Event parseClassName]];
    [query includeKey:@"pricingModel"];
    [query whereKey:@"date" greaterThan:[self tonightEnd]];
    
    _futureEvents = [query findObjects];
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(eventManager:didLoadFutureEvents:)]){
        [self.delegate eventManager:self didLoadFutureEvents:_futureEvents];
    }
}


@end
