//
//  User.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *xmppId;
@property (nonatomic, strong) NSString *xmppPassword;

@end
