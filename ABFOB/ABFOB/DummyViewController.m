//
//  DummyViewController.m
//  ABFOB
//
//  Created by Zac Adams on 5/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "DummyViewController.h"

@implementation DummyViewController

#pragma mark - Tab item

- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@""
                                      image:[UIImage imageNamed:@""]
                           andSelectedImage:[UIImage imageNamed:@""]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}



@end
