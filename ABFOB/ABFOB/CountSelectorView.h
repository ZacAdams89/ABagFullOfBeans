//
//  CountSelectorView.h
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountSelectorViewDelegate;

@interface CountSelectorView : UIView

@property (nonatomic) NSInteger value;
@property (nonatomic, weak) id<CountSelectorViewDelegate> delegate;

@end

@protocol CountSelectorViewDelegate <NSObject>

@required
- (void)countSelectorView:(CountSelectorView *)countSelector didChangeValue:(NSInteger) value;

@end
