//
//  Transaction.m
//  ABFOB
//
//  Created by Zac Adams on 31/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

@dynamic bondCharged;
@dynamic chargedRate;
@dynamic totalCharged;
@dynamic bondRefunded;
@dynamic stockCharged;
@dynamic quantity;
@dynamic refund;
@dynamic cashAmount;
@dynamic cardAmount;
@dynamic paidByCreditCard;
@dynamic chargePaid;
@dynamic bondPaid;
@dynamic bondWaived;
@dynamic bondPaymentMethod;
@dynamic chargePaymentMethod;

+ (NSString *)parseClassName {
    return @"Transaction";
}

- (NSString *)totalChargeString{
    return  string(@"$%0.2f", self.totalCharge);
}

- (NSString *)chargeSummaryString{
    
    double beanBagCost = [self chargeRate];
    double bond = [self bondCharge];
    
    NSString *bondString = @"";
    if(self.bondWaived){
        bondString = @"bond waived";
    }
    else if (self.hasBondCharge){
        bondString = string(@"$%0.2f bond", bond);
    }
    else{
        bondString = @"No bond";
    }
    
    return string(@"%dx Bean bags @ $%0.2f + %@", self.quantity, beanBagCost, bondString);
}


- (NSString *)quantityString{
    return string(@"%dx Bean Bags", self.quantity);
}

- (double)stockCharge{
    return [self chargeRate] * self.quantity;
}


- (double)bondCharge{
    
    if (self.bondWaived || NO == [[PricingManager singleton] hasBondCharge])
        return 0;
        
    double batches = (float)self.quantity / BEAN_BAG_BATCH_PER_BOND;
    batches = ceil(batches);
    batches = MAX(batches, 1);
    return batches * BOND_PER_BEAN_BAG_BATCH;
}


- (double)totalCharge{
    return ([self chargeRate] * self.quantity) + [self bondCharge];
}


- (double)chargeRate{
    return COST_PER_BEAN_BAG;
}


- (void)updateCost{
    self.chargedRate = COST_PER_BEAN_BAG;
    self.bondCharged = [self bondCharge];
    self.stockCharged = [self stockCharge];
    self.totalCharged = [self totalCharge];
}


- (BOOL)hasBondCharge{
    return self.bondCharge > 0;
}
@end
