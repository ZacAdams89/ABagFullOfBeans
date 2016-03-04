//
//  ItemValueLineView.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "ItemValueLineView.h"

@interface ItemValueLineView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UITextField *valueField;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ItemValueLineView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        // Title
        self.itemLabel = [[UILabel alloc] initInSuperview:self];
        self.itemLabel.text = @"Item";
        self.itemLabel.textAlignment = NSTextAlignmentLeft;
        self.itemLabel.font = FONT_OF_SIZE(20);
        
        // Field
        self.valueField = [[UITextField alloc] initInSuperview:self];
        self.valueField.userInteractionEnabled = NO;
        self.valueField.font = TITLE_FONT_OF_SIZE(20);
        self.valueField.textAlignment = NSTextAlignmentRight;
        self.valueField.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.valueField];
        
        // Seperator
        self.lineView = [[UIView alloc] initInSuperview:self];
        self.lineView.backgroundColor = C_BLACK;
    }
    return self;
}

- (void)dealloc{
    [self unregisterAllNotifications];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    // Line
    [self.lineView setEdge:UIViewEdgeBottom length:1/SCREEN_SCALE];
    
    // Item
    
    NSDictionary *attributes = @{
                              NSFontAttributeName:self.itemLabel.font
                              };
    
    CGRect rect = [self.itemLabel.text boundingRectWithSize:s(self.width, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    [self.itemLabel setEdge:UIViewEdgeLeft length:rect.size.width insets:i(0, 0, self.lineView.height, 5)];
    
    
    // Value
    [self.valueField sizeToFit];
    [self.valueField setEdge:UIViewEdgeRight length:self.valueField.width insets:i(0, 5, self.lineView.height, 0)];
}

- (void)setItemTitle:(NSString *)itemTitle{
    
    _itemTitle = itemTitle;
    self.itemLabel.text = itemTitle;
}


- (void)setItemValue:(NSString *)itemValue{
    
    _itemValue = itemValue;
    self.valueField.text = itemValue;
}

- (void)updateValueSize{
    [self.valueField sizeToFit];
    [self.valueField setEdge:UIViewEdgeRight length:self.valueField.width];
}

#pragma mark - Detail

- (void)setItemValuePrefixView:(UIView *)itemValuePrefixView{
    _itemValuePrefixView = itemValuePrefixView;
    
    self.valueField.leftViewMode = UITextFieldViewModeAlways;
    self.valueField.leftView = itemValuePrefixView;
}


#pragma mark - Editing

- (void)setEditable:(BOOL)editable{
    _editable = editable;
    self.valueField.userInteractionEnabled = editable;
}

- (void)setItemValueKeyboardInterface:(UIKeyboardType)itemValueKeyboardInterface{
    _itemValueKeyboardInterface = itemValueKeyboardInterface;
    self.valueField.keyboardType = itemValueKeyboardInterface;
}



#pragma mark - Text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    [self updateValueSize];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
}

- (void)valueFieldDidChange:(NSNotification *)notification{
    _itemValue = self.valueField.text;
    [self updateValueSize];
}

@end
