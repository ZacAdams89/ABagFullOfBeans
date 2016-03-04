//
//  TabItemView.h
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 10/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImage *selectedIcon;

+ (TabItem *)tabItemWithTitle:(NSString *)title
                        image:(UIImage *)image
              andSelectedImage:(UIImage *)selectedImage;

@end
