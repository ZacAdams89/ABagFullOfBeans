//
//  EventCollectionViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 11/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) Event *event;
+ (NSString *)reuseIdentifier;
+ (CGSize)cellSize;

@end
