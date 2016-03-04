//
//  UserTableViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@property (nonatomic, strong) User *user;

@end
