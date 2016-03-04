//
//  EventEarning.h
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventEarnings : NSObject

@property (nonatomic, readonly) double cashEarnings;
@property (nonatomic, readonly) double cardEarnings;
@property (nonatomic, readonly) NSInteger cashLets;
@property (nonatomic, readonly) NSInteger cardLets;
@property (nonatomic, readonly) double totalEarnings;

+ (EventEarnings *)earningsWithCashEarnings:(double)cashEarnings
                               fromCashLets:(NSInteger)cashLets
                            andCardEarnings:(double)cardEarnings
                               fromCardLets:(NSInteger)cardLets
                                  totalling:(double)total;


@end
