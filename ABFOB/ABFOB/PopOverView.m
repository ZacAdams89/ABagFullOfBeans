//
//  PopOverView.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "PopOverView.h"

@interface PopOverView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation PopOverView

- (instancetype)initWithContentView:(UIView *)contentView{
    self = [super init];
    if(self){
        
        // Background
        self.bgView = [[UIView alloc] initFullInSuperview:self];
        self.bgView.backgroundColor = [C_WHITE colorWithAlphaComponent:0.95f];
        
        // Content
        self.contentView = contentView;
        [self addSubview:self.contentView];
        [self.contentView centerInSuperview];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(NO == self.shown){
        self.contentView.top = self.bottom;
    }
}

- (void)show{
    
    
    __weak PopOverView *weakSelf = self;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.hidden = NO;
                         self.contentView.hidden = NO;
                         self.contentView.top = self.bottom - self.contentView.height;
                         
                     } completion:^(BOOL finished) {
                         NSLog(@"Pop over %@", weakSelf);
                         NSLog(@"Content view %@", weakSelf.contentView);
                     }];
    
    
    //
    [self registerForKeyboardNotifications];
    
}

- (void)hide{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.hidden = YES;
                         self.contentView.hidden = YES;
                         self.contentView.top = self.bottom;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}


//
- (void)registerForKeyboardNotifications{
    [self registerForNotification:UIKeyboardWillShowNotification selector:@selector(keyboardWillShow:)];
    [self registerForNotification:UIKeyboardWillHideNotification selector:@selector(keyboardWillHide:)];
}

//
- (void)unregisterForKeyboardNotifications{
    [self unregisterAllNotifications];
}

//
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
                            
                            self.contentView.y = self.height - self.contentView.height - height*1.5;
                            
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
                            
                            self.contentView.y = self.height - self.contentView.height;
                            
                        } completion:^(BOOL finished) {
                            
                        }];
}

@end
