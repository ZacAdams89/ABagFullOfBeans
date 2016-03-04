//
//  Event.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "PFObject.h"

@class EventEarnings;

@interface Event : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, readonly) PFRelation *customers;
@property (nonatomic, readonly) PFRelation *lets;
@property (nonatomic) NSInteger stock;
@property (nonatomic) NSInteger stockAvailable;
@property (nonatomic, strong) EventPricingModel *pricingModel;
@property (nonatomic) BOOL active;

@end


@interface Event (Earnings)

- (EventEarnings *)earnings;

@end