//
//  Pricing.h
//  ABFOB
//
//  Created by Zac Adams on 31/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#ifndef Pricing_h
#define Pricing_h

#import "PricingModel.h"
#import "PricingManager.h"

/*
#define COST_PER_BEAN_BAG 15.00
#define BEAN_BAG_BATCH_PER_BOND 2
#define BOND_PER_BEAN_BAG_BATCH 10
*/


#define COST_PER_BEAN_BAG [PricingManager singleton].chargeRate
#define BEAN_BAG_BATCH_PER_BOND [PricingManager singleton].beanBagsPerBondCharge
#define BOND_PER_BEAN_BAG_BATCH [PricingManager singleton].bondRate


#endif /* Pricing_h */
