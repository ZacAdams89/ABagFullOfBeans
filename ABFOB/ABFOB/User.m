//
//  User.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic password;
@dynamic xmppId;
@dynamic xmppPassword;


+ (NSString *)parseClassName{
    return @"User";
}

@end
