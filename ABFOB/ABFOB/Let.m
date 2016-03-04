//
//  Let.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "Let.h"


@implementation Let

@dynamic stockLet;
@dynamic timeLet;
@dynamic returned;
@dynamic refundedBond;
@dynamic stockLost;
@dynamic timeReturned;
@dynamic transaction;
@dynamic customer;
@dynamic stockDamaged;
@dynamic status;
@dynamic creator;
@dynamic bondWaived;

+ (NSString *)parseClassName {
    return @"Let";
}


@end
