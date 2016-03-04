//
//  TabItemView.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 14/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabItem.h"


@interface TabItemCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString *)reuseIdentifier;


@property (nonatomic, strong) TabItem *tabItem;

@end
