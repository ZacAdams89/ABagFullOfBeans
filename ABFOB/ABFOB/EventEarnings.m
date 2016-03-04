//
//  EventEarning.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventEarnings.h"

@implementation EventEarnings

- (instancetype)initWithCashEarnings:(double)cashEarnings
                        fromCashLets:(NSInteger)cashLets
                      andCardEarnigs:(double)cardEarnings
                        fromCardLets:(NSInteger)cardLets
                                  totalling:(double)total{
    self = [super init];
    if(self){
        _cardEarnings = cardEarnings;
        _cashEarnings = cashEarnings;
        _cardLets = cardLets;
        _cashLets = cashLets;
        _totalEarnings = total;
    }
    return self;
}

+ (EventEarnings *)earningsWithCashEarnings:(double)cashEarnings
                               fromCashLets:(NSInteger)cashLets
                            andCardEarnings:(double)cardEarnings
                               fromCardLets:(NSInteger)cardLets
                                  totalling:(double)total
{
    EventEarnings *earnings = [[EventEarnings alloc] initWithCashEarnings:cashEarnings fromCashLets:cashLets andCardEarnigs:cardEarnings fromCardLets:cardLets totalling:total];
    return earnings;
}

@end
