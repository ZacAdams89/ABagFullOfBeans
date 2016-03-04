//
//  Event.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "Event.h"
#import "EventEarnings.h"

@implementation Event

@dynamic name;
@dynamic date;
@dynamic customers;
@dynamic lets;
@dynamic stock;
@dynamic stockAvailable;
@dynamic pricingModel;
@dynamic active;

+ (NSString *)parseClassName {
    return @"Event";
}

@end



@implementation Event (Earnings)

- (EventEarnings *)earnings{

    PFQuery *query = [self.lets query];
    [query includeKey:@"transaction"];
    [query includeKey:@"customer"];
    [query whereKeyExists:@"transaction"];
    [query whereKeyExists:@"customer"];
    
    NSArray *lets = [query findObjects];
    
    // Cash lets
    NSArray *cashLets = [lets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"transaction.paymentType == %d", PaymentTypeCash]];
    double cashEarnings = [self calculateEarningsFromLets:cashLets];
    
    // Calculate the total stock let
    NSInteger cashLetCount  = 0;
    for(Let *let in cashLets){
        cashLetCount += let.stockLet;
    }

    // Card lets
    NSArray *cardLets = [lets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"transaction.paymentType == %d", PaymentTypeEftpos]];
    double cardEarnings = [self calculateEarningsFromLets:cardLets];
    
    // Calculate the total stock let
    NSInteger cardLetCount  = 0;
    for(Let *let in cardLets){
        cardLetCount += let.stockLet;
    }
    
    // Final earnings
    EventEarnings *earnings = [EventEarnings earningsWithCashEarnings:cashEarnings
                                                         fromCashLets:cashLetCount
                                                      andCardEarnings:cardEarnings
                                                         fromCardLets:cardLetCount
                                                            totalling:cashEarnings+cardEarnings];
    return earnings;
}


// Sums the charged amount on the supplied lets
- (double)calculateEarningsFromLets:(NSArray *)lets{

    double amountCleared = 0.0f;
    for(Let *let in lets){
        if(let.transaction)
            amountCleared += [let.transaction stockCharge];
    }
    return amountCleared;
}

@end
