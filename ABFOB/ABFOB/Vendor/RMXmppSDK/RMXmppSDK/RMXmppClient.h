//
//  RMXmppClient.h
//  RMXmppSDK
//
//  Created by Zac Adams on 14/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  RMXmppClientDelegate;

@interface RMXmppClient : NSObject

@property (nonatomic, readonly) BOOL isXmppConnected;
@property (nonatomic, weak) id<RMXmppClientDelegate> delegate;

+ (instancetype)sharedInstance;


/*!
 * @method
 *
 *  @discussion
 *     Authenticates the Xmpp stream with the users credentials.
 */
- (void)loginWithJId:(NSString *)jId
              andPassword:(NSString *)clientPassword;


/*!
 * @method
 *
 *  @discussion
 *     Sends a message to a reciepient
 *
 *  @param message The message body to send\
 *  @param contactId The jabber id of the receipient.
 */
- (void)sendMessage:(NSString *)message
          toContact:(NSString *)contactId;

@end


@protocol RMXmppClientDelegate <NSObject>

@required

- (void)xmppClient:(RMXmppClient *)client didReceivedMessage:(NSString *)message fromContact:(RMXmppContact *)contact;


@end