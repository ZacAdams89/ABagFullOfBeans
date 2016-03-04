//
//  RMXmppJID.h
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMXmppJID : NSObject

@property (nonatomic, readonly) NSString *jIdStr;
@property (nonatomic, readonly) NSString *user;
@property (nonatomic, readonly) NSString *domain;
@property (nonatomic, readonly) NSString *resource;

+ (RMXmppJID *)jidWithJIdStr:(NSString *)jbIdStr;
//+ (RMXmppJID *)jidWithJIdStr:(NSString *)jbIdStr andResource:(NSString *)resource;
//+ (RMXmppJID *)jidWithJIdStr:(NSString *)jbIdStr andName:(NSString *)name;
//+ (RMXmppJID *)jidWithJIdStr:(NSString *)jbIdStr andName:(NSString *)name;
//+ (RMXmppJID *)jidWithUser:(NSString *)user domain:(NSString *)domain;
//+ (RMXmppJID *)jidWithUser:(NSString *)user domain:(NSString *)domain andResource:(NSString *)resource;

@end
