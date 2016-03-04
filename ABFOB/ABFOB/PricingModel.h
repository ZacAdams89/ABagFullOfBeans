//
//  PriceModel.h
//  ABFOB
//
//  Created by Zac Adams on 21/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Parse/Parse.h>

@interface PricingModel : PFObject<PFSubclassing>

@property (nonatomic) double chargeRate;
@property (nonatomic) double bondRate;
@property (nonatomic) NSInteger beanBagsPerBondCharge;

@end
