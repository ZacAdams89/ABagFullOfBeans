//
//  MessageManager.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *kMessageNewLetMadeNotification;


@interface MessageManager : NSObject<Singleton>

- (void)sendNewLetMessage:(Let *)let;
- (void)sendLetCancledMessage:(Let *)let;
- (void)sendLetCheckedoutMessage:(Let *)let;
- (void)sendLetReturnedMessage:(Let *)let;


@end
