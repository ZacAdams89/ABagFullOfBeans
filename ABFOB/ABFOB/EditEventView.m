//
//  EditEventView.m
//  ABFOB
//
//  Created by Zac Adams on 26/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EditEventView.h"
#import "ItemValueLineView.h"
#import "CashLabel.h"

@interface EditEventView ()

@property (nonatomic, strong) ItemValueLineView *stockLine;
@property (nonatomic, strong) ItemValueLineView *chargeRateLine;
@property (nonatomic, strong) ItemValueLineView *bondRateLine;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation EditEventView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.title = @"Edit event";
        
        // Stock
        self.stockLine = [[ItemValueLineView alloc] initInSuperview:self.contentView];
        self.stockLine.itemTitle = @"Stock";
        self.stockLine.itemValueKeyboardInterface = UIKeyboardTypeNumberPad;
        self.stockLine.editable = YES;
        
        // Charge rate
        self.chargeRateLine = [[ItemValueLineView alloc] initInSuperview:self.contentView];
        self.chargeRateLine.itemTitle = @"Charge rate";
        self.chargeRateLine.itemValueKeyboardInterface = UIKeyboardTypeDecimalPad;
        self.chargeRateLine.itemValuePrefixView = [[CashLabel alloc] initWithSize:s(20,20)];
        self.chargeRateLine.editable = YES;
        
        // Bond rate
        self.bondRateLine = [[ItemValueLineView alloc] initInSuperview:self.contentView];
        self.bondRateLine.itemTitle = @"Bond rate";
        self.bondRateLine.itemValueKeyboardInterface = UIKeyboardTypeDecimalPad;
        self.bondRateLine.itemValuePrefixView = [[CashLabel alloc] initWithSize:s(20,20)];
        self.bondRateLine.editable = YES;
        
        // Save button
        self.saveButton = [[UIButton alloc] initInSuperview:self.contentView];
        [self.saveButton addTarget:self action:@selector(save)];
        self.saveButton.backgroundColor = C_LIGHT_GRAY;
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        
        
        // We will handle our own save buttons
        self.showDoneButton = NO;
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.stockLine.size = s(self.width, 40);
    self.chargeRateLine.size = s(self.width, 40);
    self.bondRateLine.size = s(self.width, 40);
    
    [self.contentView stackSubviewsAgainstEdge:UIViewEdgeTop insets:inset(20) spacing:5];
    
    // Bank the save button to the bottom
    [self.saveButton setEdge:UIViewEdgeBottom length:50];
}

- (void)setEvent:(Event *)event{
    _event = event;
    
    // Stock
    self.stockLine.itemValue = string(@"%d", event.stock ? event.stock : 0);
    
    // Charge Rate
    self.chargeRateLine.itemValue = string(@"%0.2f", event.pricingModel.chargeRate ?  event.pricingModel.chargeRate : 0.0f);
    
    // Bond rate
    self.bondRateLine.itemValue = string(@"%0.2f", event.pricingModel.bondRate ? event.pricingModel.bondRate : 0.0f);
}

- (void)done{
    self.event.pricingModel.chargeRate = [self.chargeRateLine.itemValue doubleValue];
    self.event.pricingModel.bondRate = [self.bondRateLine.itemValue doubleValue];
    self.event.stock = [self.bondRateLine.itemValue integerValue];
    
    [self.event.pricingModel saveInBackground];
    [self.event saveInBackground];
    
    [super done];
}


- (void)cancel{
    
}

- (void)save{
    [self done];
}
@end
