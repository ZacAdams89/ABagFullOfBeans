//
//  UserManager.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

@property (nonatomic, strong) NSArray *users;

@end

@implementation UserManager


- (void)setup{
    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        self.users = objects;
        
    }];
}

- (User *)loggedInUser{

    return [PFUser currentUser];
//    if(nil == _loggedInUser){
//    
//        PFUser *currentUser = [PFUser currentUser];
//        User *user = [self userFromPFUser:currentUser];
//        _loggedInUser = user;
//    }
//        
//    return _loggedInUser;
}

- (User *)userFromPFUser:(PFUser *)pfUser{
    for(User* user in self.users){
        if([user.username isEqualToString:pfUser.username]){
            return user;
        }
    }
    
    return nil;
}

@end

