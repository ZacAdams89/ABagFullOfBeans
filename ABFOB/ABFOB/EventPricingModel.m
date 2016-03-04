//
//  EventPricingModel.m
//  ABFOB
//
//  Created by Zac Adams on 26/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventPricingModel.h"

@implementation EventPricingModel

@dynamic chargeRate;
@dynamic bondRate;
@dynamic beanBagsPerBondCharge;

+ (NSString *)parseClassName {
    return @"EventPricingModel";
}

@end
