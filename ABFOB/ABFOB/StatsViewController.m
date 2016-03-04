//
//  StatsViewController.m
//  ABFOB
//
//  Created by Zac Adams on 10/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "StatsViewController.h"

@implementation StatsViewController


- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@"Stats"
                                      image:[UIImage imageNamed:@"stats"]
                           andSelectedImage:[UIImage imageNamed:@"stats-selected"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}

@end
