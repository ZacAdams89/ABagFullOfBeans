//
//  ItemValueLineView.h
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemValueLineView : UIView

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemValue;

#pragma mark - detail

@property (nonatomic, strong) UIView *itemValuePrefixView;

#pragma mark - Editing

@property (nonatomic, assign) UIKeyboardType itemValueKeyboardInterface;
@property (nonatomic) BOOL editable;


@end
