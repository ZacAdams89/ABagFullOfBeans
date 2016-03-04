//
//  PopOverView.h
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverView : UIView

@property (nonatomic) BOOL shown;

- (instancetype)initWithContentView:(UIView *)contentView;
- (void)show;
- (void)hide;


@end
