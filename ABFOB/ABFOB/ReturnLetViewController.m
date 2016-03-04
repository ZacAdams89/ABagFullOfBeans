//
//  ReturnLetViewController.m
//  ABFOB
//
//  Created by Zac Adams on 10/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "ReturnLetViewController.h"
#import "LetDetailsView.h"
#import "VariableContextCounter.h"

@interface ReturnLetViewController ()<VariableContextCounterDelegate>

@property (nonatomic, strong) LetDetailsView *letDetailsView;
@property (nonatomic, strong) VariableContextCounter *lostBeanBagsCounter;
@property (nonatomic, strong) VariableContextCounter *damagedBeanBagsCounter;


// Bond
@property (nonatomic, strong) UIView *bondSeperatorLineView;
@property (nonatomic, strong) UILabel *bondTitleLabel;
@property (nonatomic, strong) UILabel *bondMessageLabel;
@property (nonatomic, strong) UISwitch *bondRefundedSwitch;
@property (nonatomic, strong) UILabel *switchLabel;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ReturnLetViewController

- (void)viewDidLoad{
    
    self.view.backgroundColor = C_WHITE;
    
    //
    
    self.letDetailsView = [[LetDetailsView alloc] initInSuperview:self.view];
    self.letDetailsView.let = self.let;
    
    self.lostBeanBagsCounter = [[VariableContextCounter alloc] initInSuperview:self.view];
    self.lostBeanBagsCounter.title = @"Lost bean bags";
    self.lostBeanBagsCounter.delegate = self;
    
    self.damagedBeanBagsCounter = [[VariableContextCounter alloc] initInSuperview:self.view];
    self.damagedBeanBagsCounter.title = @"Damaged bean bags";
    self.damagedBeanBagsCounter.delegate = self;
    
    
    //
    self.bondSeperatorLineView = [[UIView alloc] initInSuperview:self.view];
    self.bondSeperatorLineView.backgroundColor = C_LIGHT_GRAY;
    
    self.bondTitleLabel = [[UILabel alloc] initInSuperview:self.view];
    self.bondTitleLabel.font = TITLE_FONT_OF_SIZE(20);
    self.bondTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.bondTitleLabel.text = @"";
    
    self.bondMessageLabel = [[UILabel alloc] initInSuperview:self.view];
    self.bondMessageLabel.font = FONT_OF_SIZE(15);
    self.bondMessageLabel.textAlignment = NSTextAlignmentCenter;
    self.bondMessageLabel.text = @"";
    self.bondMessageLabel.numberOfLines = 0;
    self.bondMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.bondRefundedSwitch = [[UISwitch alloc] initInSuperview:self.view];
    self.bondRefundedSwitch.on = NO;
    [self.bondRefundedSwitch addTarget:self action:@selector(refundedBond) forControlEvents:UIControlEventValueChanged];
    
    self.switchLabel  =[[UILabel alloc] initInSuperview:self.view];
    self.switchLabel.font = SECONDARY_FONT_SIZE(10);
    self.switchLabel.textAlignment = NSTextAlignmentCenter;
    self.switchLabel.text = @"Refunded bond";

    
    
    self.doneButton = [[UIButton alloc] initInSuperview:self.view];
    [self.doneButton setTitle:@"Returned" forState:UIControlStateNormal];
    self.doneButton.titleLabel.font = FONT_OF_SIZE(20);
    self.doneButton.backgroundColor = C_LIGHT_GRAY;
    [self.doneButton addTarget:self action:@selector(done)];
    self.doneButton.hidden = YES;
    
    
    self.cancelButton = [[UIButton alloc] initInSuperview:self.view];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = TITLE_FONT_OF_SIZE(15);
    [self.cancelButton addTarget:self action:@selector(cancel)];
    [self.cancelButton setTitleColor:C_BLACK forState:UIControlStateNormal];
    
    
    
    [self updateBondState];
    

}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.letDetailsView setEdge:UIViewEdgeTop length:100 insets:i(70, 20, 0, 20)];
    [self.lostBeanBagsCounter setEdge:UIViewEdgeTop length:100 insets:inset_top(self.letDetailsView.bottom + 10)];
    [self.damagedBeanBagsCounter setEdge:UIViewEdgeTop length:100 insets:inset_top(self.lostBeanBagsCounter.bottom + 5)];
    
    
    //
    [self.bondSeperatorLineView setEdge:UIViewEdgeTop length:SCREEN_SCALE/2 insets:inset_top(self.damagedBeanBagsCounter.bottom + 10)];

    [self.bondTitleLabel setEdge:UIViewEdgeTop length:20 insets:inset_top(self.bondSeperatorLineView.bottom + 10)];
    
    [self.bondMessageLabel setEdge:UIViewEdgeTop length:20 insets:inset_top(self.bondTitleLabel.bottom + 5)];
    
    [self.bondRefundedSwitch setEdge:UIViewEdgeTop size:s(100, 30) insets:inset_top(self.bondMessageLabel.bottom + 5)];
    self.bondRefundedSwitch.centerX = self.view.centerX;
    
    [self.switchLabel setEdge:UIViewEdgeTop length:15 insets:inset_top(self.bondRefundedSwitch.bottom + 5)];
    
    
    [self.doneButton setEdge:UIViewEdgeBottom length:50];
    
    [self.cancelButton setCorner:UIViewCornerTopLeft size:s(60, 30) insets:i(30, 0, 0, 20)];
}


- (void)updateBondState{
    if(self.damagedBeanBagsCounter.contextOn ||
       self.lostBeanBagsCounter.contextOn){
        
        // Claculate bont
        NSInteger accountedBeanBags = self.lostBeanBagsCounter.value + self.damagedBeanBagsCounter.value;
        NSInteger bondSetsToRefund = ceil((self.let.stockLet - accountedBeanBags)/BEAN_BAG_BATCH_PER_BOND);
        double amountToRefund = bondSetsToRefund * BOND_PER_BEAN_BAG_BATCH;
        
        // Cap at the bond actually charged
        amountToRefund = MAX(amountToRefund, self.let.transaction.bondCharged);
        
        if(amountToRefund > 0){
            self.bondTitleLabel.text =  string(@"$%0.2f", amountToRefund);
            self.bondMessageLabel.text = string(@"Bond to be repaid %@", self.let.transaction.bondPaymentMethod == PaymentTypeCash ? @"in Cash" : @"by Card" );
        }
        else{
            self.bondTitleLabel.text = @"No bond refund";
            self.bondMessageLabel.text = @"No refund on damaged or lost goods";
        }
        
        self.bondRefundedSwitch.hidden = YES;
        self.switchLabel.hidden = YES;
        self.doneButton.hidden = NO;
    }
    else if(NO == self.let.transaction.bondPaid){
        
        self.bondTitleLabel.text = @"No bond held";
        self.bondMessageLabel.text = @"No bond was paid upon purchase\n, no bond to be repaid";
        self.bondRefundedSwitch.hidden = YES;
        self.switchLabel.hidden = YES;
        self.doneButton.hidden = NO;
    }
    else{
        // No context active
        self.bondTitleLabel.text =  string(@"$%0.2f", [self.let.transaction bondCharged]);
        self.bondMessageLabel.text = string(@"Bond to be repaid %@", self.let.transaction.bondPaymentMethod == PaymentTypeCash ? @"in Cash" : @"by Card" );

        self.bondRefundedSwitch.hidden = NO;
        self.switchLabel.hidden = NO;
        self.doneButton.hidden = !self.bondRefundedSwitch.on;
    }
}

#pragma mark - Variable context delegate

- (void)variableContextCounter:(VariableContextCounter *)variableCounter didSwitchTo:(BOOL)onOff{
    [self updateBondState];
}


- (void)variableContextCounter:(VariableContextCounter *)variableCounter didSelectValaue:(NSInteger)value{
    [self updateBondState];
}


#pragma mark - Actions


- (void)refundedBond{
    self.doneButton.hidden = !self.bondRefundedSwitch.on;
}

- (void)done{

    self.let.stockDamaged = self.damagedBeanBagsCounter.contextOn;
    self.let.stockLost = self.lostBeanBagsCounter.value;
    self.let.refundedBond = self.bondRefundedSwitch.on;
    self.let.timeReturned = [NSDate date];
    self.let.status = LetStateReturned;
    self.let.returned = YES;
    [self.let saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        // Update its transaction
        self.let.transaction.bondRefunded = self.bondRefundedSwitch.on;
        [self.let.transaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(self.delegate &&
               [self.delegate respondsToSelector:@selector(didReturnLet:)]){
                [self.delegate didReturnLet:self.let];
            }
            
            [self cancel];
        }];
        
    }];
    

}


- (void)cancel{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
