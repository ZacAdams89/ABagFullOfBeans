//
//  LetTableViewCell.h
//  ABFOB
//
//  Created by Zac Adams on 2/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Let *let;

+ (CGSize)cellSize;
+ (NSString *)reuseIdentifier;



@end

