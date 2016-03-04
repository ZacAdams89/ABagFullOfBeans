//
//  TabBarViewController.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 10/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic) BOOL tabInteractionEnabled;

- (void)setActiveTab:(NSInteger)tab;

@end
