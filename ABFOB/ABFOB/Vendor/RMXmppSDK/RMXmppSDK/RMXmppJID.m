//
//  RMXmppJID.m
//  RMXmppSDK
//
//  Created by Zac Adams on 15/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import "RMXmppJID.h"

@implementation RMXmppJID

- (instancetype)initWithUser:(NSString *)user domain:(NSString *)domain andResource:(NSString *)resource{
    self = [super init];
    if(self){
        _user = user;
        _domain = domain;
        resource = resource;
        
    }
    return self;
}

- (instancetype)initWithJIdStr:(NSString *)jIdStr{
    self = [super init];
    if(self){
        //TODO: Split the id into user, domain and resource
        NSArray *components = [jIdStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@/"]];
        
        // Order of elemnets user@domain.dm/resource
        // 0 = order
        // 1 = domain
        // 2 = resource
        _user = components[0];
        _domain = components[1];
        
        if([jIdStr containsString:@"/"]){
            // There is a resource component
            _resource = components[2];
        }
    }
    return self;
}


- (NSString *)jIdStr{
    NSString *jIdStr = [NSString stringWithFormat:@"%@@%@", self.user, self.domain];
    if(self.resource.length){
        jIdStr = [jIdStr stringByAppendingString:[NSString stringWithFormat:@"/%@", self.resource]];
    }
    
    return jIdStr;
}


+ (RMXmppJID *)jidWithJIdStr:(NSString *)jbIdStr
{
    RMXmppJID *jId = [[RMXmppJID alloc] initWithJIdStr:jbIdStr];
    return jId;
}




@end
