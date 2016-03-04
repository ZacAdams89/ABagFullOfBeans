//
//  EventManager.h
//  ABFOB
//
//  Created by Zac Adams on 5/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^results)(NSArray *events, NSError *error);

@protocol EventManagerDelegate;

@interface EventManager : NSObject<Singleton>

@property (nonatomic, readonly) Event *activeEvent;

@property (nonatomic, readonly) NSArray *todaysEvents;
@property (nonatomic, readonly) NSArray *pastEvents;
@property (nonatomic, readonly) NSArray *futureEvents;

- (void)addDelegate:(id<EventManagerDelegate>)delegate;

@end



@protocol EventManagerDelegate <NSObject>

@required
- (void)eventManager:(EventManager *)eventManager didLoadTodaysEvents:(NSArray *)events;
- (void)eventManager:(EventManager *)eventManager didLoadPastEvents:(NSArray *)events;
- (void)eventManager:(EventManager *)eventManager didLoadFutureEvents:(NSArray *)events;

@end