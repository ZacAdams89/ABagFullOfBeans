//
//  PopOverContentView.h
//  ABFOB
//
//  Created by Zac Adams on 26/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverContentView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL showDoneButton;

// Overide to process actions upon pressing the done button
- (void)done;

//Overide to process actions upon pressing the close button
- (void)cancel;

@end
