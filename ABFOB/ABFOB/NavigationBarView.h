//
//  NavigationBarView.h
//  ABFOB
//
//  Created by Zac Adams on 1/03/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarView : UIView

// Title
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *titleView;

// Left action
@property (nonatomic, strong) NSString *leftActionTitle;
@property (nonatomic) BOOL showLeftAction;

// Right action
@property (nonatomic, strong) NSString *rightActionTitle;
@property (nonatomic) BOOL showRightAction;

//
@property (nonatomic) CGFloat barHeight;


@end
