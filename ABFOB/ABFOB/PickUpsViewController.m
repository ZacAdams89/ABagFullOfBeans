//
//  PickUpsViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "PickUpsViewController.h"
#import "LetCollectionViewController.h"

@interface PickUpsViewController ()<UICollectionViewDelegate>

/// Array of lets that have not been picked up
@property (nonatomic, strong) NSArray *letsToPickUp;

@property (nonatomic, strong) LetCollectionViewController *letCollectionViewController;

@end

@implementation PickUpsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Pick Ups" image:[UIImage imageNamed:@"pick-ups"] tag:1];
    self.title = @"Pick Ups";
    
    self.letCollectionViewController = [[LetCollectionViewController alloc] initWithLetType:LetTypePickups];
    [self addChildViewController:self.letCollectionViewController];
    [self.view addSubview:self.letCollectionViewController.view];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.letCollectionViewController.collectionView fill];
}

- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@"Pickups"
                                      image:[UIImage imageNamed:@"pick-ups"]
                           andSelectedImage:[UIImage imageNamed:@"pick-ups-selected"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}

@end
