//
//  RMXppPressence.m
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import "RMXmppPressence.h"


@implementation RMXmppPressence

- (instancetype)initWithStatus:(RMXmppPressenceStatus) status{
    self = [super init];
    if(self){
        _status = status;
    }
    return self;
}

+ (RMXmppPressence *)pressenceWithStatus:(RMXmppPressenceStatus) status
{
    RMXmppPressence *pressence = [[RMXmppPressence alloc] initWithStatus:status];
    return pressence;
}

@end
