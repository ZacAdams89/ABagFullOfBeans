//
//  TagableView.h
//  ABFOB
//
//  Created by Zac Adams on 16/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagableView : UIView

- (void)addTag:(NSString *)tagTitle;
- (void)clear;

@end
