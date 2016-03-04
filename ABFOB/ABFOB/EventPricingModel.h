//
//  EventPricingModel.h
//  ABFOB
//
//  Created by Zac Adams on 26/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Parse/Parse.h>

@interface EventPricingModel : PFObject<PFSubclassing>

@property (nonatomic) double chargeRate;
@property (nonatomic) double bondRate;
@property (nonatomic) NSInteger beanBagsPerBondCharge;

@end
