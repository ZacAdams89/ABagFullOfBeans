//
//  Transaction.h
//  ABFOB
//
//  Created by Zac Adams on 31/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import <Parse/Parse.h>

typedef NS_ENUM(NSInteger, PaymentType){
    PaymentTypeEftpos = 0,
    PaymentTypeCash,
    PaymentTypeMultipart,
    PaymentTypeCount,
};


@interface Transaction : PFObject<PFSubclassing>

@property (nonatomic) double bondCharged;
@property (nonatomic) double chargedRate;
@property (nonatomic) double totalCharged;
@property (nonatomic) BOOL bondRefunded;
@property (nonatomic) NSInteger stockCharged;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) PaymentType paymentType;
@property (nonatomic, strong) Refund *refund;
@property (nonatomic) double cashAmount;
@property (nonatomic) double cardAmount;
@property (nonatomic) BOOL paidByCreditCard;
@property (nonatomic) BOOL chargePaid;
@property (nonatomic) BOOL bondPaid;
@property (nonatomic) BOOL bondWaived;
@property (nonatomic) PaymentType bondPaymentMethod;
@property (nonatomic) PaymentType chargePaymentMethod;

@property (nonatomic, readonly) NSString *totalChargeString;
@property (nonatomic, readonly) NSString *chargeSummaryString;
@property (nonatomic, strong) NSString *quantityString;
@property (nonatomic, readonly) BOOL hasBondCharge;

- (double)bondCharge;
- (double)stockCharge;
- (double)totalCharge;
- (double)chargeRate;
- (void)updateCost;

@end
