//
//  PricingManager.h
//  ABFOB
//
//  Created by Zac Adams on 21/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PricingManager : NSObject<Singleton>

@property (nonatomic) double chargeRate;
@property (nonatomic) double bondRate;
@property (nonatomic) NSInteger beanBagsPerBondCharge;
@property (nonatomic, readonly) BOOL hasBondCharge;

@end
