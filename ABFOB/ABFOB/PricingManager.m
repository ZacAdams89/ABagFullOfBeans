//
//  PricingManager.m
//  ABFOB
//
//  Created by Zac Adams on 21/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "PricingManager.h"

@interface PricingManager ()

@property (nonatomic, strong) PricingModel *pricingModel;

@end

@implementation PricingManager


- (void)setup{
    
    PFQuery *pricingModelQuery = [PricingModel query];
    NSArray *pricingModels = [pricingModelQuery findObjects];
    self.pricingModel = [pricingModels firstObject];
}

- (double)chargeRate{
    NSParameterAssert(self.pricingModel);
    return self.pricingModel.chargeRate;
}


- (double)bondRate{
    NSParameterAssert(self.pricingModel);
    return self.pricingModel.bondRate;
}


- (NSInteger)beanBagsPerBondCharge{
    NSParameterAssert(self.pricingModel);
    return self.pricingModel.beanBagsPerBondCharge;
}


- (BOOL)hasBondCharge{
    return self.pricingModel.bondRate > 0;
}

@end
