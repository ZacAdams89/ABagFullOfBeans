//
//  UserManager.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject<Singleton>

@property (nonatomic, strong) User *loggedInUser;

- (User *)userFromPFUser:(PFUser *)pfUser;

@end
