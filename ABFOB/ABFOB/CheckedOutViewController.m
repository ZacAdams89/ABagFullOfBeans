//
//  CheckedOutViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "CheckedOutViewController.h"
#import "LetCollectionViewController.h"

@interface CheckedOutViewController ()

@property (nonatomic, strong) LetCollectionViewController *letCollectionViewController;

@end

@implementation CheckedOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Checkouts";
    
    self.letCollectionViewController = [[LetCollectionViewController alloc] initWithLetType:LetTypeCheckedOut];
    [self addChildViewController:self.letCollectionViewController];
    [self.view addSubview:self.letCollectionViewController.view];
    [self.letCollectionViewController.view fillInsets:inset_top(kNavigationBarHeight+kStatusBarHeight)];
    
    [self registerForNotification:kMessageNewLetMadeNotification selector:@selector(newLetMade)];
}

- (void)newLetMade{
    [self.letCollectionViewController.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        
        
        tabItem = [TabItem tabItemWithTitle:@"Checkout"
                                      image:[UIImage imageNamed:@"bean-bag"]
                           andSelectedImage:[UIImage imageNamed:@"bean-bag-selected"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}

@end
