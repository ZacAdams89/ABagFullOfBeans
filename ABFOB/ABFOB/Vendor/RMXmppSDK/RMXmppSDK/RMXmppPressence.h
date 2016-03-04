//
//  RMXppPressence.h
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RMXmppPressenceStatus){
    RMXmppPressenceStatusOnline = 0,
    RMXmppPressenceStatusOffline,
    RMXmppPressenceStatusAway,
    RMXmppPressenceStatusInvisible,
    RMXmppPressenceStatusCustom,
};

@interface RMXmppPressence : NSObject

@property (nonatomic, readonly) RMXmppPressenceStatus status;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIColor *color;

+ (RMXmppPressence *)pressenceWithStatus:(RMXmppPressenceStatus) status;

@end
