//
//  RMXmppContact.h
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMXmppJID.h"

@interface RMXmppContact : NSObject

@property (nonatomic, readonly) RMXmppJID *jId;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) RMXmppPressenceStatus status;
@property (nonatomic, readonly) NSString *title;

+ (RMXmppContact *)contactWithJId:(RMXmppJID *)jId;

@end
