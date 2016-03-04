//
//  MessageManager.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "MessageManager.h"

const NSString *kMessageNewLetMadeNotification = @"NewLetMadeNotification";

@interface MessageManager ()

//@property (nonatomic, strong) RMXmppClient *xmppClient;

@end

@implementation MessageManager


- (void)setup{
    // Get the client details
//    self.xmppClient = [[RMXmppClient alloc] init];
//    
//    User *loggedInUser = [UserManager singleton].loggedInUser;
//    [self.xmppClient loginWithJId:loggedInUser.xmppId  andPassword:loggedInUser.xmppPassword];
}


- (void)sendNewLetMessage:(Let *)let{
    
    // Broad cast the new let having been made
    [self broadcastNotification:kMessageNewLetMadeNotification];
}

- (void)sendLetCancledMessage:(Let *)let{
}

- (void)sendLetCheckedoutMessage:(Let *)let
{
}

- (void)sendLetReturnedMessage:(Let *)let
{
}

@end
