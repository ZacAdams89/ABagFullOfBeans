//
//  NewLetViewController.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabContentViewController.h"

@protocol NewLetViewControllerDelegate;

@interface NewLetViewController : TabContentViewController

@property (nonatomic, weak) id<NewLetViewControllerDelegate> delegate;

- (void)clear;

@end


@protocol NewLetViewControllerDelegate <NSObject>

@required
- (void)didCompleteNewLet;

@end
