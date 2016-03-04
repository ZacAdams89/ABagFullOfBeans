//
//  StatsViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) UILabel *loggedInUserLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = C_WHITE;
    
        self.title = @"Settings";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"stats"] tag:3];
    
    
    
    self.summaryLabel = [[UILabel alloc] initInSuperview:self.view];
    self.summaryLabel.font = SECONDARY_FONT_SIZE(20);
    self.summaryLabel.textAlignment = NSTextAlignmentCenter;
    self.summaryLabel.text = @"Logged in as";
    
    self.loggedInUserLabel = [[UILabel alloc] initInSuperview:self.view];
    self.loggedInUserLabel.font = FEATURE_FONT_OF_SIZE(30);
    self.loggedInUserLabel.textAlignment = NSTextAlignmentCenter;
    self.loggedInUserLabel.text = [UserManager singleton].loggedInUser.username;
    
    
    self.logoutButton = [[UIButton alloc] initInSuperview:self.view];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    self.logoutButton.backgroundColor = C_LIGHT_GRAY;
    [self.logoutButton addTarget:self
                          action:@selector(logout)];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.summaryLabel setEdge:UIViewEdgeTop length:25 insets:inset_top(64)];
    [self.loggedInUserLabel setEdge:UIViewEdgeTop length:35 insets:inset_top(self.summaryLabel.bottom + 5)];
    [self.logoutButton setEdge:UIViewEdgeTop length:50 insets:inset_top(self.loggedInUserLabel.bottom + 20)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@"Settings"
                                      image:[UIImage imageNamed:@"settings"]
                           andSelectedImage:[UIImage imageNamed:@"settings-selected"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}


- (void)logout{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [ABFOBAppDelegate showLoginScreen];
    }];
}

@end
