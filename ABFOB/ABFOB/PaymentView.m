//
//  PaymentView.m
//  ABFOB
//
//  Created by Zac Adams on 3/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "PaymentView.h"

#define EMPTY_OPTION_FIELD_VALUE @"0.00"


@interface PaymentView ()<UITextFieldDelegate>

// title
@property (nonatomic, strong) UILabel *titleLabel;

// Credit card switch
@property (nonatomic, strong) UISwitch *creditCardSwitch;
@property (nonatomic, strong) UILabel *creditCardSwitchLabel;

// Payment options
@property (nonatomic, strong) UIView *paymentOptionsContainer;
@property (nonatomic, strong) UITextField *chargeTextField;
@property (nonatomic, strong) UITextField *bondTextField;
@property (nonatomic, strong) UITextField *totalTextField;
@property (nonatomic, strong) UISegmentedControl *chargePaymentMethodControl;
@property (nonatomic, strong) UISegmentedControl *bondPaymentMethodControl;
@property (nonatomic, strong) UIView *bondView;

//
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end


@implementation PaymentView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        // title
        self.titleLabel = [[UILabel alloc] initInSuperview:self];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = TITLE_FONT_OF_SIZE(15);
        self.titleLabel.text = @"Payment Options";
        
        // Credit card
        self.creditCardSwitch = [[UISwitch alloc] initInSuperview:self];
        self.creditCardSwitch.on = NO;
        
        self.creditCardSwitchLabel = [[UILabel alloc] initInSuperview:self];
        self.creditCardSwitchLabel.textAlignment = NSTextAlignmentCenter;
        self.creditCardSwitchLabel.text = @"Credit card?";
        self.creditCardSwitchLabel.font = SECONDARY_FONT_SIZE(10);
        
        // Payment details
        self.paymentOptionsContainer = [[UIView alloc] initInSuperview:self];
        
        
        self.chargePaymentMethodControl = [[UISegmentedControl alloc] init];
        
        self.chargeTextField = [self field];
        [self.paymentOptionsContainer addSubview:[self paymentLineWithTitle:@"Charge" inputField:self.chargeTextField paymentMethodControl:self.chargePaymentMethodControl andValue:@"0.00"]];
        

        
        self.bondPaymentMethodControl = [[UISegmentedControl alloc] init];
        
        self.bondTextField = [self field];
        
        self.bondView = [self paymentLineWithTitle:@"Bond" inputField:self.bondTextField paymentMethodControl:self.bondPaymentMethodControl andValue:@"0.00"];
        
        [self.paymentOptionsContainer addSubview:self.bondView];
        
        self.totalTextField = [self field];
        self.totalTextField.userInteractionEnabled = NO;
        [self.paymentOptionsContainer addSubview:[self paymentLineWithTitle:@"Total" inputField:self.totalTextField paymentMethodControl:nil andValue:@"0.00"]];
        
        // Payment done
        self.doneButton = [[UIButton alloc] initInSuperview:self];
        [self.doneButton setTitle:@"Payment complete" forState:UIControlStateNormal];
        [self.doneButton addTarget:self action:@selector(paymentComplete)];
        self.doneButton.backgroundColor = C_LIGHT_GRAY;
        
        
        // Cancel button
        self.cancelButton = [[UIButton alloc] initInSuperview:self];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancel)];
        [self.cancelButton setTitleColor:C_BLACK forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = SECONDARY_FONT_SIZE(15);
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
        
        
    }
    return self;
}

- (void)setTransaction:(Transaction *)transaction{

    _transaction = transaction;
    
    
    // default to card payment
    self.chargeTextField.text = string(@"%0.2f", transaction.stockCharge);
    
    // Default cash payment is 0;
    self.bondTextField.text = string(@"%0.2f", transaction.bondCharged);
    
    // Set the total
    self.totalTextField.text = string(@"%0.2f", transaction.totalCharged);
    
    self.bondView.hidden = transaction.bondWaived || NO == transaction.hasBondCharge;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    // Title
    [self.titleLabel setEdge:UIViewEdgeTop length:20 insets:inset_top(20)];

    
    // Credit card switch
    [self.creditCardSwitch setEdge:UIViewEdgeTop size:s(100, 40) insets:inset_top(self.titleLabel.bottom + 20)];
    self.creditCardSwitch.centerX = self.centerX;
    [self.creditCardSwitchLabel setEdge:UIViewEdgeTop length:10 insets:inset_top(self.creditCardSwitch.bottom + 5)];
    
    
    // Payment button
    [self.doneButton setEdge:UIViewEdgeBottom length:50 insets:inset_bottom(0)];
    
    
    // Payment options
    [self.paymentOptionsContainer fillInsets:i(self.creditCardSwitchLabel.bottom + 30, 20, self.doneButton.height + 20, 20)];
    
    // Layout the payment lines in the payment container
    [self.paymentOptionsContainer stackSubviewsAgainstEdge:UIViewEdgeTop insets:CGInsetsZero spacing:10];
    
    
    // Cancel
    [self.cancelButton setCorner:UIViewCornerTopLeft size:s(100, 20) insets:i(20, 0, 0, 5)];
}

- (UIView *)paymentLineWithTitle:(NSString *)title inputField:(UITextField *)field paymentMethodControl:(UISegmentedControl *)paymentMehtodControl andValue:(NSString *)value{
    
    UIView *paymentLineView = [[UIView alloc] initWithSize:s(300, 50)];
    
    
    // Title
    UILabel *titleLabel = [[UILabel alloc] initInSuperview:paymentLineView edge:UIViewEdgeLeft length:80];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = FONT_OF_SIZE(20);
    
    
    // Seperator
    UILabel *seperatorLine = [[UIView alloc] initInSuperview:paymentLineView edge:UIViewEdgeBottom length:SCREEN_SCALE/2];
    seperatorLine.backgroundColor = C_BLACK;
    
    // Inject the field
    [paymentLineView addSubview:field];
    [field setEdge:UIViewEdgeLeft length:100 insets:inset_left(titleLabel.right + 10)];
    field.textAlignment = NSTextAlignmentLeft;
    field.text = value;
    
    if(paymentMehtodControl){
    
        [paymentLineView addSubview:paymentMehtodControl];
        [paymentMehtodControl insertSegmentWithTitle:@"Card" atIndex:0 animated:NO];
        [paymentMehtodControl insertSegmentWithTitle:@"Cash" atIndex:1 animated:NO];
        [paymentMehtodControl setEdge:UIViewEdgeRight length:100 insets:i(5, 20, 5, 0)];
        [paymentMehtodControl setSelectedSegmentIndex:0];
    }

    
    return paymentLineView;
    
}

- (UITextField *)field{
    UITextField *field = [[UITextField alloc] init];
    field.font = TITLE_FONT_OF_SIZE(20);
    field.keyboardType = UIKeyboardTypeDecimalPad;
    field.delegate = self;
    field.leftViewMode = UITextFieldViewModeAlways;
    
    
    UILabel *label = [[UILabel alloc] initWithSize:s(20, 30)];
    label.font = TITLE_FONT_OF_SIZE(20);
    label.text = @"$";
    field.leftView = label;
    
    
    // Observe when the field changes
    [field addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    return field;
}



- (void)cancel{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(paymentViewDidCancel:)]){
        [self.delegate paymentViewDidCancel:self];
    }
}


- (void)paymentComplete{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(paymentView:didCompleteWithType:charge:chargePaymentMehtod:bondAmount:bondChargePaymentType:isCreditcard:)]){
     
        // Defaults as full card payment
        PaymentType type = PaymentTypeEftpos;
        
        double charge = [self.chargeTextField.text doubleValue];
        double bond = [self.bondTextField.text doubleValue];
        
        double total = charge + bond;
        
        // Disable the button so we cant hit it twice.
        self.doneButton.enabled = NO;
        
        PaymentType overallType = PaymentTypeEftpos;
        if(self.chargePaymentMethodControl.selectedSegmentIndex != self.bondPaymentMethodControl.selectedSegmentIndex){
            overallType = PaymentTypeMultipart;
        }
        else{
            // They are the same so take any
            overallType = (PaymentType)self.chargePaymentMethodControl.selectedSegmentIndex;
        }
        
    
        [self.delegate paymentView:self didCompleteWithType:overallType
                            charge:charge
               chargePaymentMehtod:(PaymentType)self.chargePaymentMethodControl.selectedSegmentIndex
                        bondAmount:bond
             bondChargePaymentType:(PaymentType)self.bondPaymentMethodControl.selectedSegmentIndex
                      isCreditcard:self.creditCardSwitch.on];
    }
}


- (void)clear
{
    self.creditCardSwitch.on = NO;
    
    // Disable the button so we cant hit it twice.
    self.doneButton.enabled = YES;
    [self cancel];
    
    
    // Reset Cash vs Card
    [self.chargePaymentMethodControl setSelectedSegmentIndex:0];
    [self.bondPaymentMethodControl setSelectedSegmentIndex:0];
}

#pragma mark - Text field delegate

- (void)textFieldDidChange:(NSNotification *)notification{
    
    
    double charge = [self.chargeTextField.text doubleValue];
    double bond = [self.bondTextField.text doubleValue];
    double total = charge + bond;
    
    self.totalTextField.text = string(@"%0.2f", total);
    
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
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
                        options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            
                            self.y -= height*1.5;
                            
                        } completion:^(BOOL finished) {
                            
                        }];

}


- (void)keyboardWillHide:(NSNotification *)notification{
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
                            
                            self.y += height;
                            
                        } completion:^(BOOL finished) {
                            
                        }];
}

@end

