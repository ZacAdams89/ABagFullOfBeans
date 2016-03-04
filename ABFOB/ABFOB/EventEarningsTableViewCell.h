//
//  EventEarningsTableViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventEarningsTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (double)cellHeight;

@property (nonatomic, strong) Event *event;

@end
