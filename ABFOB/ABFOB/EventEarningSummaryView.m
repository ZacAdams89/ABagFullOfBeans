//
//  EventEarningSummaryView.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventEarningSummaryView.h"

#import "EventEarnings.h"
#import "ItemValueLineView.h"

@interface EventEarningSummaryView ()

@property (nonatomic, strong) ItemValueLineView *cashEarningsLineView;
@property (nonatomic, strong) ItemValueLineView *cardEarningsLineView;
@property (nonatomic, strong) ItemValueLineView *totalEarningsLineView;
@property (nonatomic, strong) EventEarnings *earnings;

@end

@implementation EventEarningSummaryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        // Cash earnings
        self.cashEarningsLineView = [[ItemValueLineView alloc] initInSuperview:self];
        self.cashEarningsLineView.itemTitle = @"Cash Earnings";
        self.cashEarningsLineView.itemValuePrefixView = [self cashLabel];
        
        // Card earnings
        self.cardEarningsLineView = [[ItemValueLineView alloc] initInSuperview:self];
        self.cardEarningsLineView.itemTitle = @"Card earnings";
        self.cardEarningsLineView.itemValuePrefixView = [self cashLabel];

    
        // Total earnings
        self.totalEarningsLineView = [[ItemValueLineView alloc] initInSuperview:self];
        self.totalEarningsLineView.itemTitle = @"Total earnings";
        self.totalEarningsLineView.itemValuePrefixView = [self cashLabel];
}
    return self;
}

- (UILabel *)cashLabel{
    UILabel *label = [[UILabel alloc] initWithSize:s(20, 30)];
    label.font = TITLE_FONT_OF_SIZE(20);
    label.text = @"$";
    return label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // Cash
    self.cashEarningsLineView.size = s(self.width, 50);
    self.cardEarningsLineView.size = s(self.width, 50);
    self.totalEarningsLineView.size = s(self.width, 50);
    [self stackSubviewsAgainstEdge:UIViewEdgeTop];
}

- (void)setEvent:(Event *)event{
    _event = event;
    
    
    // Earnings
    self.earnings = event.earnings;
    
    // Card
    self.cardEarningsLineView.itemTitle = string(@"%dx Card lets @%0.2f", self.earnings.cardLets, self.event.pricingModel.chargeRate);
    self.cardEarningsLineView.itemValue = string(@"%0.2f", self.earnings.cardEarnings);
    
    // Cash
    self.cashEarningsLineView.itemTitle = string(@"%dx Cash lets @%0.2f", self.earnings.cashLets, self.event.pricingModel.chargeRate);
    self.cashEarningsLineView.itemValue = string(@"%0.2f", self.earnings.cashEarnings);
    
    // Total
    self.totalEarningsLineView.itemTitle = string(@"%dx Total lets @%0.2f", self.earnings.cashLets + self.earnings.cardLets, self.event.pricingModel.chargeRate);
    self.totalEarningsLineView.itemValue = string(@"%0.2f", self.earnings.totalEarnings);
}

@end
