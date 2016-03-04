//
//  VariableContextCounter.h
//  ABFOB
//
//  Created by Zac Adams on 10/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VariableContextCounterDelegate;

@interface VariableContextCounter : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id<VariableContextCounterDelegate> delegate;
@property (nonatomic, readonly) BOOL contextOn;
@property (nonatomic, readonly) NSInteger value;

@end


@protocol VariableContextCounterDelegate <NSObject>

@required
- (void)variableContextCounter:(VariableContextCounter *)variableCounter didSwitchTo:(BOOL)onOff;
- (void)variableContextCounter:(VariableContextCounter *)variableCounter didSelectValaue:(NSInteger)value;

@end
