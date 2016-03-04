//
//  PriceModel.m
//  ABFOB
//
//  Created by Zac Adams on 21/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "PricingModel.h"

@implementation PricingModel


@dynamic chargeRate;
@dynamic bondRate;
@dynamic beanBagsPerBondCharge;

+ (NSString *)parseClassName {
    return @"PricingModel";
}


@end
