
//
//  EventSectionHeaderCollectionViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 4/03/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSectionHeaderCollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
+ (CGSize)cellSize;

@property (nonatomic, strong) NSString *title;

@end
