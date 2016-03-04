//
//  LetTableViewController.h
//  ABFOB
//
//  Created by Zac Adams on 2/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LetType){
    LetTypePickups = LetStateAwaitingPickUp,
    LetTypeCheckedOut = LetStateCheckedOut,
};

@interface LetCollectionViewController : UICollectionViewController

@property (nonatomic, readonly) LetType letType;
- (instancetype)initWithLetType:(LetType)letType;

@end
