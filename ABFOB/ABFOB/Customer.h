//
//  Customer.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "PFObject.h"

@interface Customer : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic) NSInteger totalStockLet;
@property (nonatomic) NSInteger totalStockDamaged;
@property (nonatomic) NSInteger totalStockLost;
@property (nonatomic) BOOL risk;
@property (nonatomic, readonly) PFRelation *lets;
@property (nonatomic, readonly) NSArray *events;

@end
