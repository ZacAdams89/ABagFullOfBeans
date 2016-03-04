//
//  LetDetailsView.m
//  ABFOB
//
//  Created by Zac Adams on 5/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetDetailsView.h"
#import "TagableView.h"

@interface LetDetailsView ()

// Customer
@property (nonatomic, strong) UIView *customerDetailsView;
@property (nonatomic, strong) UILabel *customerNameLabel;
@property (nonatomic, strong) UILabel *customerMobileLabel;

// Let details
@property (nonatomic, strong) UIView *letDetailsView;
@property (nonatomic, strong) UILabel *letSummaryLabel;
@property (nonatomic, strong) UILabel *paymentSummaryLabel;
@property (nonatomic, strong) UILabel *bondSummaryLabel;

// Tags
@property (nonatomic, strong) TagableView *tagsView;

@end

@implementation LetDetailsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        // Customer
        self.customerDetailsView = [[UIView alloc] initInSuperview:self];
        self.customerNameLabel = [[UILabel alloc] initInSuperview:self.customerDetailsView];
        self.customerNameLabel.text = @"Customer name";
        self.customerNameLabel.font = TITLE_FONT_OF_SIZE(20);
        self.customerNameLabel.textAlignment = NSTextAlignmentLeft;
        
        
        self.customerMobileLabel = [[UILabel alloc] initInSuperview:self.customerDetailsView];
        self.customerMobileLabel.text = @"021 034 1261";
        self.customerMobileLabel.textAlignment = NSTextAlignmentLeft;
        self.customerMobileLabel.font = SECONDARY_FONT_SIZE(15);
        
        // Let
        self.letDetailsView = [[UIView alloc]  initInSuperview:self];
        
        self.letSummaryLabel = [[UILabel alloc] initInSuperview:self.letDetailsView];
        self.letSummaryLabel.font = TITLE_FONT_OF_SIZE(20);
        self.letSummaryLabel.textAlignment = NSTextAlignmentLeft;
        self.letSummaryLabel.text = @"2x Bean Bags";
        
        self.paymentSummaryLabel = [[UILabel alloc] initInSuperview:self.letDetailsView];
        self.paymentSummaryLabel.textAlignment = NSTextAlignmentLeft;
        self.paymentSummaryLabel.font = FONT_OF_SIZE(10);
        self.paymentSummaryLabel.text = @"$40 paid";
        
        self.bondSummaryLabel = [[UILabel alloc] initInSuperview:self.letDetailsView];
        self.bondSummaryLabel.text = @"$20 bond held";
        self.bondSummaryLabel.textAlignment = NSTextAlignmentLeft;
        self.bondSummaryLabel.font = FONT_OF_SIZE(10);
        
        // Tags
        self.tagsView = [[TagableView alloc] initInSuperview:self];
    
        
        self.layer.borderColor = C_LIGHT_GRAY.CGColor;
        self.layer.borderWidth = SCREEN_SCALE/2;

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    // Tags
    const CGFloat kTagsViewHeight = 30;
    const CGFloat kTopInset = 20;
    const CGFloat kSideInsets = 20;
    
    //
    [self.tagsView setEdge:UIViewEdgeBottom length:kTagsViewHeight];
    
    // Customer
    [self.customerDetailsView setEdge:UIViewEdgeLeft length:self.width/2 insets:inset_bottom(self.tagsView.height)];
    [self.customerNameLabel setEdge:UIViewEdgeTop length:25 insets:i(kTopInset, kSideInsets, 0, kSideInsets)];
    [self.customerMobileLabel setEdge:UIViewEdgeTop length:25 insets:i(self.customerNameLabel.bottom + 5, kSideInsets, 0, kSideInsets)];
    
    // Let
    [self.letDetailsView setEdge:UIViewEdgeRight length:self.width/2 insets:inset_bottom(kTagsViewHeight)];
    [self.letSummaryLabel setEdge:UIViewEdgeTop length:25 insets:i(kTopInset, kSideInsets, 0, kSideInsets)];
    [self.paymentSummaryLabel setEdge:UIViewEdgeTop length:10 insets:i(self.letSummaryLabel.bottom + 5, kSideInsets, 0, kSideInsets)];
    [self.bondSummaryLabel setEdge:UIViewEdgeTop length:10 insets:i(self.paymentSummaryLabel.bottom + 5, kSideInsets, 0, kSideInsets)];
}


- (void)addTag:(NSString *)tagTitle{
    [self.tagsView addTag:tagTitle];
}

- (void)setLet:(Let *)let{
    _let = let;
    
    // Clear any tags
    [self.tagsView clear];
    
    // Update customer detail UI
    Customer *customer = let.customer;
    self.customerNameLabel.text = customer.firstName;
    self.customerMobileLabel.text = customer.mobile;
    
    // Update let & transaction UI
    Transaction *transaction = let.transaction;
    self.letSummaryLabel.text = [transaction quantityString];
    self.paymentSummaryLabel.text = [[transaction totalChargeString] stringByAppendingString:@" Paid"];
    
    // Update the bond state
    if(let.bondWaived){
        self.bondSummaryLabel.text = @"Bond waived";
    }
    else if(let.transaction.hasBondCharge){
        self.bondSummaryLabel.text = string(@"%0.2f bond %@", transaction.bondCharged, let.transaction.bondPaid ? @"Held" : @"Not paid");
    }
    else{
        self.bondSummaryLabel.text = string(@"No bond");
    }
    
    // Display the lets payment state
    if(let.transaction.chargePaid){
        switch (let.transaction.paymentType) {
            case PaymentTypeCash:
                [self addTag:@"Paid in cash"];
                break;
                
            case PaymentTypeEftpos:
                [self addTag:@"Paid by card"];
                break;
                
            case PaymentTypeMultipart:
                [self addTag:@"Paid in cash & card"];
                break;
                
            default:
                break;
        }
    }
    
    // Display the lets bond state
    if(self.let.transaction.bondPaid){
        switch (self.let.transaction.bondPaymentMethod) {
            case PaymentTypeCash:
                [self addTag:@"Bond paid in Cash"];
                break;
                
            case PaymentTypeEftpos:
                [self addTag:@"Bond paid by Card"];
                break;
                
            default:
                break;
        }
    }
    
    // Display the lets active state
    switch (self.let.status) {
        case LetStateCheckedOut:
            [self addTag:@"Checked out"];
            break;
            
        case LetStateCancelled:
            [self addTag:@"Cancelled"];
            break;
            
        case LetStateReturned:
            [self addTag:@"Returned"];
            break;
            
            case LetStateNotReturned:
            [self addTag:@"Not returned"];
            break;
            
        default:
            break;
    }
}


@end
