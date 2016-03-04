//
//  QuickCountSelector.h
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuickCountSelectorDelegate;

@interface QuickCountSelector : UIView

@property (nonatomic) NSInteger count;
@property (nonatomic, weak) id<QuickCountSelectorDelegate> delegate;
@property (nonatomic) NSInteger value;

- (void)clear;

@end


@protocol QuickCountSelectorDelegate <NSObject>

@required
- (void)quickCountSelector:(QuickCountSelector *)selector didSelectCount:(NSInteger) count;

@end




