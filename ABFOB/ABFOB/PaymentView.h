//
//  PaymentView.h
//  ABFOB
//
//  Created by Zac Adams on 3/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentViewDelegate;

@interface PaymentView : UIView

@property (nonatomic, weak) id<PaymentViewDelegate> delegate;

@property (nonatomic, weak) Transaction *transaction;
- (void)clear;

@end

@protocol PaymentViewDelegate <NSObject>

@required
- (void)paymentViewDidCancel:(PaymentView *)paymentView;
- (void)paymentView:(PaymentView *)paymentView didCompleteWithType:(PaymentType)paymentType charge:(double)charge chargePaymentMehtod:(PaymentType)chargeType bondAmount:(double)bond bondChargePaymentType:(PaymentType)bondType isCreditcard:(BOOL)isCreditCard;

@end
