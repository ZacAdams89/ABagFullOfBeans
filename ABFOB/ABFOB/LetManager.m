//
//  LetManager.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetManager.h"

@implementation LetManager

- (void)cancelLet:(Let *)let{
    
    // Cancel the let
    let.status = LetStateCancelled;
    [let saveInBackground];
    
    // Update the available stock on the event
    [EventManager singleton].activeEvent.stockAvailable += let.stockLet;
    [[EventManager singleton].activeEvent saveInBackground];
    
    // Done
}

- (void)checkoutLet:(Let *)let
{
    // Check out the let
    let.status = LetStateCheckedOut;
    [let saveInBackground];
}

@end
