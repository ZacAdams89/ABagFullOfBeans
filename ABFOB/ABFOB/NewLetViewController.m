//
//  NewLetViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "NewLetViewController.h"
#import "QuickCountSelector.h"
#import "CountSelectorView.h"
#import "PaymentView.h"

@interface NewLetViewController ()<QuickCountSelectorDelegate, CountSelectorViewDelegate, UITextFieldDelegate, PaymentViewDelegate>

//
@property (nonatomic, strong) UIScrollView *contentScrollView;

// Stock UI
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceSummaryLabel;
@property (nonatomic, strong) QuickCountSelector *quickCountSelectorCollectionView;
@property (nonatomic, strong) CountSelectorView *countSelectorView;
@property (nonatomic) NSInteger beanBagsToLet;


// Credit card switch

@property (nonatomic, strong) UISwitch *bondSwitch;
@property (nonatomic, strong) UILabel *bondSwitchLabel;

// Customer UI
@property (nonatomic, strong) UIView *customerDetailsContainerView;
@property (nonatomic, strong) UIView *customerNameComponentView;
@property (nonatomic, strong) UIView *customerMobileNumberComponentView;
@property (nonatomic, strong) UITextField *customerNameField;
@property (nonatomic, strong) UITextField *customerMobileNumberField;


// Payment UI
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) PaymentView *paymentView;
@property (nonatomic, strong) UIView *paymentViewContainer;

// Data
@property (nonatomic, strong) Transaction *transaction;


// Getsure
@property (nonatomic, strong) UITapGestureRecognizer *keyboardDismissGesture;

@end

@implementation NewLetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = C_WHITE;;
    
    [self initLet];
    
    
    self.keyboardDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.keyboardDismissGesture];
    self.keyboardDismissGesture.enabled = NO;
    
    // Stock UI
    
    self.priceLabel = [[UILabel alloc] initInSuperview:self.view];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.font = FEATURE_FONT_OF_SIZE(60);
    
    
    //
    self.priceSummaryLabel = [[UILabel alloc] initInSuperview:self.view];
    self.priceSummaryLabel.textAlignment = NSTextAlignmentCenter;
    self.priceSummaryLabel.font = FONT_OF_SIZE(10);
    
    //
    self.quickCountSelectorCollectionView = [[QuickCountSelector alloc] initInSuperview:self.view];
    self.quickCountSelectorCollectionView.delegate = self;
    self.quickCountSelectorCollectionView.count = 6;
    self.quickCountSelectorCollectionView.backgroundColor = C_LIGHT_GRAY;
    
    //
    self.countSelectorView = [[CountSelectorView alloc] initInSuperview:self.view];
    self.countSelectorView.delegate = self;
    self.countSelectorView.value = 1;
    
    
    self.beanBagsToLet = 1;
    
    
    self.bondSwitch = [[UISwitch alloc] initInSuperview:self.view];
    self.bondSwitch.on = NO;
    [self.bondSwitch addTarget:self action: @selector(toggleBondWaver) forControlEvents:UIControlEventValueChanged];
    //    self.bondSwitch.userInteractionEnabled = YES;
    //    self.bondSwitch.enabled = YES;

    
    self.bondSwitchLabel = [[UILabel alloc] initInSuperview:self.view];
    self.bondSwitchLabel.textAlignment = NSTextAlignmentCenter;
    self.bondSwitchLabel.text = @"Wave bond?";
    self.bondSwitchLabel.font = SECONDARY_FONT_SIZE(10);

    if(NO == [[PricingManager singleton] hasBondCharge]){
        //
        self.bondSwitch.hidden = YES;
        self.bondSwitchLabel.hidden = YES;
    }
    
    // Customer UI
    self.customerNameField = [self textFieldWithPlaceholderText:@"Name"
                                                   keyboardType:UIKeyboardTypeAlphabet
                                               andReturnKeyType:UIReturnKeyNext];
    
    self.customerMobileNumberField = [self textFieldWithPlaceholderText:@"Mobile Number"
                                                           keyboardType:UIKeyboardTypeNamePhonePad
                                                       andReturnKeyType:UIReturnKeyDone];
    
    self.customerNameComponentView = [self componentGroupWithTitle:@"Customer name" andComponent:self.customerNameField];
    self.customerMobileNumberComponentView = [self componentGroupWithTitle:@"Mobile #" andComponent:self.customerMobileNumberField];
    
    self.customerDetailsContainerView = [[UIView alloc] initInSuperview:self.view];
    
    [self.customerDetailsContainerView addSubview:self.customerNameComponentView];
    [self.customerDetailsContainerView addSubview:self.customerMobileNumberComponentView];
    
    
    // Pay button
    self.payButton = [[UIButton alloc] initInSuperview:self.view];
    [self.payButton setTitle:@"Pay" forState:UIControlStateNormal];
    [self.payButton addTarget:self action:@selector(pay)];
    self.payButton.backgroundColor = C_LIGHT_GRAY;
    
    //
    
    // Payment view
    self.paymentViewContainer = [[UIView alloc] initInSuperview:self.view];
    self.paymentViewContainer.alpha = 0.95f;
    self.paymentViewContainer.backgroundColor = C_WHITE;
    self.paymentViewContainer.hidden = YES;
    
    self.paymentView = [[PaymentView alloc] initInSuperview:self.view];
    self.paymentView.delegate = self;
    self.paymentView.hidden = YES;
    
    

    
    // Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.quickCountSelectorCollectionView.value = 1;
}


- (void)initLet{
    self.transaction = [Transaction object];
}

- (void)toggleBondWaver{
    self.transaction.bondWaived = self.bondSwitch.on;
    [self update];
}

- (void)done{
    
    
    if([self validate]){
        
        __weak NewLetViewController *weakSelf = self;
        
        // save the transaction
        [self.transaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            // Create the customer
            Customer *customer = [Customer object];
            customer.firstName = self.customerNameField.text;
            customer.mobile = self.customerMobileNumberField.text;
            [customer saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                
                // Create the let
                Let *let = [Let object];
                let.customer = customer;
                let.stockLet = weakSelf.beanBagsToLet;
                let.bondWaived = self.transaction.bondWaived;
                let.transaction = weakSelf.transaction;
                let.customer = customer;
                let.status = LetStateCheckedOut; // Changed to checked out as there is only 1 worker
                let.creator = [[UserManager singleton] loggedInUser];
                [let saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                  
                    [customer.lets addObject:let];
                    [customer saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        
//                        // Todays event
                        Event *activeEvent = [EventManager singleton].activeEvent;
                        [activeEvent.lets addObject:let];
                        [activeEvent.customers addObject:customer];
                        activeEvent.stockAvailable = activeEvent.stockAvailable - let.stockLet;
                        [activeEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            if(succeeded){
                                if(weakSelf.delegate &&
                                   [weakSelf.delegate respondsToSelector:@selector(didCompleteNewLet)]){
                                    [weakSelf.delegate didCompleteNewLet];
                                    
                                    //
                                    [[MessageManager singleton] sendNewLetMessage:let];
                                }
                            }
                        }];
                    }];

                }];
                
            }];
            
        }];

        
//        Customer *customer = [Customer object];
//        customer.firstName = self.customerNameField.text;
//        customer.mobile = self.customerMobileNumberField.text;
//        
//        Let *let = [Let object];
//        let.customer = customer;
//        let.stockLet = self.beanBagsToLet;
//        let.transaction = self.transaction;
//        let.customer = customer;
//        
//        [let saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            int i = 0;
//        }];
    }
    
}

- (BOOL)validate{
    
    BOOL valid = YES;
    
    if(self.customerNameField.text.length == 0){
        valid = NO;
        [self.customerNameComponentView shake];
    }
    
    if(self.customerMobileNumberField.text.length == 0){
        valid = NO;
        [self.customerMobileNumberComponentView shake];
    }
    
    return valid;
}


- (UITextField *)textFieldWithPlaceholderText:(NSString *)placeHolderText
                              keyboardType:(UIKeyboardType)keyboardType
                                 andReturnKeyType:(UIReturnKeyType)returnKeyType
{
    
    UITextField *textField = [[UITextField alloc] initWithSize:s(self.view.width, 40)];
    textField.placeholder = placeHolderText;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = C_BLACK;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnKeyType;
    textField.delegate = self;
    
    return textField;
}


- (UIView *)componentGroupWithTitle:(NSString *)title
                       andComponent:(UIView *)component
{
    
    const CGFloat kTitleHeight = 20;
    const CGFloat xInsets = 20;
    
    UIView *containerView = [[UIView alloc] initWithSize:s(self.view.width - (xInsets * 2), kTitleHeight + component.height + 10)];
    containerView.backgroundColor = C_WHITE;
    
    UILabel *titleLabel = [[UILabel alloc] initInSuperview:containerView edge:UIViewEdgeTop length:kTitleHeight insets:insets_x(xInsets)];
    titleLabel.text = title;
    titleLabel.textColor = C_DARK_GRAY;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:kTitleHeight];
    
    UIView *fieldBGView = [[UIView alloc] initWithSize:s(self.view.width - (xInsets*2), component.height)];
    fieldBGView.layer.borderColor = C_LIGHT_GRAY.CGColor;
    fieldBGView.layer.borderWidth = 1;
    
    
    [fieldBGView addSubview:component];
    [component fillInsets:i(5, xInsets, 5, xInsets)];
    
    [containerView addSubview:fieldBGView];
    [fieldBGView setEdge:UIViewEdgeTop length:fieldBGView.height insets:i(titleLabel.bottom + 5, xInsets, 5, xInsets)];
    fieldBGView.autoresizingMask = nil;
    
    return containerView;
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // Price
    [self.priceLabel setEdge:UIViewEdgeTop length:60 insets:inset_top(40)];
    [self.priceSummaryLabel setEdge:UIViewEdgeTop length:20 insets:inset_top(self.priceLabel.bottom +5)];
    
    // Credit card switch
    [self.bondSwitch setEdge:UIViewEdgeTop size:s(100, 40) insets:inset_top(self.priceSummaryLabel.bottom + 10)];
    self.bondSwitch.centerX = self.view.centerX;
    [self.bondSwitchLabel setEdge:UIViewEdgeTop length:10 insets:inset_top(self.bondSwitch.bottom + 5)];

    
    [self.quickCountSelectorCollectionView setEdge:UIViewEdgeTop length:50 insets:i(self.bondSwitchLabel.bottom + 10, 20, 0, 20)];
    self.countSelectorView.size = s(150, 50);
    self.countSelectorView.centerX = self.view.centerX;
    self.countSelectorView.top = self.quickCountSelectorCollectionView.bottom + 10;
    
    // Customer
    
    [self.customerNameComponentView setEdge:UIViewEdgeTop length:self.customerNameComponentView.height];

    [self.customerMobileNumberComponentView setEdge:UIViewEdgeTop length:self.customerNameComponentView.height insets:inset_top(self.customerNameComponentView.bottom + 20)];
    
    [self.customerDetailsContainerView setEdge:UIViewEdgeTop
                                        length:self.customerMobileNumberComponentView.height + self.customerNameComponentView.height + 20
                                        insets:inset_top(self.countSelectorView.bottom + 10)];
    
    
    
    // Pay button
    [self.payButton setEdge:UIViewEdgeBottom length:50];
    
    [self.paymentViewContainer fill];
    [self.paymentView fillInsets:inset_top(self.priceLabel.bottom + 50)];
}


- (void)pay{

    self.paymentView.y = self.view.height;
    self.paymentView.transaction = self.transaction;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.paymentViewContainer.hidden = NO;
                         self.paymentView.hidden = NO;
                         self.paymentView.y = self.priceLabel.bottom + 50;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

- (void)clear{
    
    // Clear the customer details
    self.customerNameField.text = @"";
    self.customerMobileNumberField.text = @"";
    
    // Reset the bean bag amount
    self.quickCountSelectorCollectionView.value = 1;
    self.countSelectorView.value = 1;
    
    // Reset the bond waiver
    self.bondSwitch.on = NO;
    
    // Reset the transaction
    self.transaction = [Transaction object];
    self.beanBagsToLet = 1;
    
    // Clear the payment view
    [self.paymentView clear];
}

#pragma mark - Tab item

- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@"New Let"
                                      image:[UIImage imageNamed:@"new-let"]
                           andSelectedImage:[UIImage imageNamed:@"new-let"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}


- (void)setBeanBagsToLet:(NSInteger)beanBagsToLet{
    _beanBagsToLet = beanBagsToLet;
    
    [self update];
}


- (void)update{
    self.transaction.quantity = self.beanBagsToLet;
    [self.transaction updateCost];
    self.priceSummaryLabel.text = [self.transaction chargeSummaryString];
    self.priceLabel.text = [self.transaction totalChargeString];
}

#pragma mark - Quick count selector

- (void)quickCountSelector:(QuickCountSelector *)selector didSelectCount:(NSInteger)count{
    self.beanBagsToLet = count;
    self.countSelectorView.value = count;
}

- (void)countSelectorView:(CountSelectorView *)countSelector didChangeValue:(NSInteger)value{
    self.beanBagsToLet = value;
    [self.quickCountSelectorCollectionView clear];
}




#pragma mark - Keyboard notifications

- (void)keyboardWillAppear:(NSNotification *)notification{

    // Enable the dismiss gestue
    self.keyboardDismissGesture.enabled = YES;
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    // Hide the value selectors
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationCurveEaseInOut animations:^{
        
                            self.customerDetailsContainerView.y -= height - self.customerDetailsContainerView.distanceBottom - 20;
                            self.quickCountSelectorCollectionView.hidden = YES;
                            self.countSelectorView.hidden = YES;
                            
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    
    // Disable the dismiss gestue
    self.keyboardDismissGesture.enabled = NO;
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    // Hide the value selectors
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationCurveEaseInOut animations:^{
                            
                            self.customerDetailsContainerView.y = self.countSelectorView.bottom + 30;
                            
                            self.quickCountSelectorCollectionView.hidden = NO;
                            self.countSelectorView.hidden = NO;
                            
                        } completion:^(BOOL finished) {
                            
                        }];
    
}

#pragma mark - Gestures

- (void)dismissKeyboard{
    
    [self.view endEditing:YES];
    
}


#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    // Process return key actions
    NSCharacterSet *returnKeyCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange r = [string rangeOfCharacterFromSet:returnKeyCharacterSet];
    if (r.location != NSNotFound) {
       
        if(textField == self.customerNameField){
            [self.customerMobileNumberField becomeFirstResponder];
        }
        else if(textField == self.customerMobileNumberField){
            [textField resignFirstResponder];
        }
        
        //Return key actiom, do not insert into text
        return NO;
    }
    
    // Not a return action, process as usual
    return YES;
}



#pragma mark - Payment view delegate

- (void)paymentViewDidCancel:(PaymentView *)paymentView{
    
    self.paymentView.y = self.view.height;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.paymentViewContainer.hidden = YES;
                         self.paymentView.y = self.paymentView.height;
                         self.paymentView.hidden = YES;
                         
                     } completion:^(BOOL finished) {

                     }];
}

- (void)paymentView:(PaymentView *)paymentView didCompleteWithType:(PaymentType)paymentType charge:(double)charge chargePaymentMehtod:(PaymentType)chargeType bondAmount:(double)bond bondChargePaymentType:(PaymentType)bondType isCreditcard:(BOOL)isCreditCard{

    self.transaction.chargePaid = charge;
    self.transaction.bondCharged = bond;
    self.transaction.bondPaymentMethod = bondType;
    self.transaction.chargePaymentMethod = chargeType;
    self.transaction.paymentType = paymentType;
    self.transaction.paidByCreditCard = isCreditCard;
    self.transaction.chargePaid = YES;
    self.transaction.bondPaid = !self.transaction.bondWaived && self.transaction.hasBondCharge;
    
    [self done];
}



@end
