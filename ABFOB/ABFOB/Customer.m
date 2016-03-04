//
//  Customer.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "Customer.h"

@implementation Customer

@dynamic firstName;
@dynamic lastName;
@dynamic mobile;
@dynamic totalStockLet;
@dynamic totalStockDamaged;
@dynamic totalStockLost;
@dynamic risk;
@dynamic lets;
@dynamic events;

+ (NSString *)parseClassName {
    return @"Customer";
}

@end
