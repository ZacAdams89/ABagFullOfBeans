
//
//  EventsLetsTableViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsLetsTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
- (double)contentHeight;

@property (nonatomic, weak) NSArray *lets;

@end
