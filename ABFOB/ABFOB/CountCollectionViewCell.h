//
//  CountCollectionViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountCollectionViewCell : UICollectionViewCell

@property (nonatomic) NSInteger value;
+ (NSString *)reuseIdentifier;
@property (nonatomic) BOOL isSelected;

@end
