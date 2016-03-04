//
//  Let.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 24/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "PFObject.h"

typedef NS_ENUM(NSInteger, LetState){
    LetStateAwaitingPickUp = 0,
    LetStateCheckedOut,
    LetStateReturned,
    LetStateCancelled,
    LetStateNotReturned,
};

@interface Let : PFObject<PFSubclassing>

@property (nonatomic) NSInteger stockLet;
@property (nonatomic) NSDate *timeLet;
@property (nonatomic) BOOL returned;
@property (nonatomic) BOOL refundedBond;
@property (nonatomic) NSInteger stockLost;
@property (nonatomic) NSDate *timeReturned;
@property (nonatomic, strong) Transaction *transaction;
@property (nonatomic, strong) Customer  *customer;
@property (nonatomic) BOOL stockDamaged;
@property (nonatomic) LetState status;
@property (nonatomic, strong) User *creator;
@property (nonatomic) BOOL bondWaived;

@end
