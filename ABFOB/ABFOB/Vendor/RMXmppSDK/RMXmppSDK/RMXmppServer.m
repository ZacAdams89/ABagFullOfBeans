//
//  RMXmppServer.m
//  RMXmppSDK
//
//  Created by Zac Adams on 14/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import "RMXmppServer.h"

@implementation RMXmppServer


/*!
 * @method
 *
 *  @discussion
 *     Creates a new server definition
 */
- (instancetype)initWithEndpoint:(NSString *)endPoint
                                port:(NSString *)port
                             andName:(NSString *)name
{
    self = [super init];
    if(self){
        _endPoint = endPoint;
        _port = port;
        _name = name;
    }
    return self;
}

/*!
 * @method
 *
 *  @discussion
 *     Creates a new server definition
 */
+ (RMXmppServer *)serverWithEndpoint:(NSString *)endPoint
                                port:(NSString *)port
                             andName:(NSString *)name
{
    RMXmppServer *server = [[RMXmppServer alloc] initWithEndpoint:endPoint port:port andName:name];
    return server;
}

@end
