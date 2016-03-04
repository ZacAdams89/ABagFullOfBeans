//
//  TabItemView.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 10/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "TabItem.h"

@implementation TabItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
             andSelectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if(self){
        _title = title;
        _icon = image;
        _selectedIcon = selectedImage;
    }
    return self;
}

+ (TabItem *)tabItemWithTitle:(NSString *)title
                        image:(UIImage *)image
              andSelectedImage:(UIImage *)selectedImage
{

    TabItem *tab = [[TabItem alloc] initWithTitle:title image:image andSelectedImage:selectedImage];
    return tab;
}

@end
