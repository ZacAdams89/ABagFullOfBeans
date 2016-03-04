//
//  RMXmppContact.m
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import "RMXmppContact.h"


@implementation RMXmppContact

- (instancetype)initWithJId:(RMXmppJID *)jId{
    self = [super init];
    if(self){
        _jId = jId;
    }
    return self;
}

+ (RMXmppContact *)contactWithJId:(RMXmppJID *)jId{
    RMXmppJID *contact = [[RMXmppContact alloc] initWithJId:jId];
    return contact;
}


- (NSString *)title{
    
    NSString *title = @"";
    
    if(self.name){
        title = self.name;
        
        if(self.jId){
            title = [title stringByAppendingString:[NSString stringWithFormat:@"(%@)", self.jId.jIdStr]];
        }
    }
    else{
        if(self.jId){
            title = self.jId.jIdStr;
        }
    }
    
    return title;
}


@end
