//
//  RMXmppServer.h
//  RMXmppSDK
//
//  Created by Zac Adams on 14/12/15.
//  Copyright © 2015 roamltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 * @class
 *
 *  @discussion
 *      Server credentials
 */
@interface RMXmppServer : NSObject

@property (nonatomic, strong) NSString *endPoint;
@property (nonatomic, strong) NSString *port;
@property (nonatomic, strong) NSString *name;

/*!
 * @method
 *
 *  @discussion
 *     Creates a new server definition
 */
+ (RMXmppServer *)serverWithEndpoint:(NSString *)endPoint
                                port:(NSString *)port
                             andName:(NSString *)name;

@end
