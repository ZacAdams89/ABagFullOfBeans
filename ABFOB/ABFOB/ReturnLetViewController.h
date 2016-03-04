//
//  ReturnLetViewController.h
//  ABFOB
//
//  Created by Zac Adams on 10/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReturnLetViewControllerDelegate;

@interface ReturnLetViewController : UIViewController

@property (nonatomic, weak) Let *let;
@property (nonatomic, weak) id<ReturnLetViewControllerDelegate> delegate;

@end


@protocol ReturnLetViewControllerDelegate <NSObject>

@required
- (void)didReturnLet:(Let *)let;

@end
