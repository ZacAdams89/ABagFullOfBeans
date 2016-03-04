//
//  LoginViewController.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LoginViewController.h"
#import "UserTableViewCell.h"
#import "PopOverView.h"
#import "PPPinPadViewController.h"


@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate, PinPadPasswordProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) PopOverView *popoverPinView;
@property (nonatomic, strong) PPPinPadViewController *pinpadVC;


@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = C_WHITE;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = C_WHITE;
    
    
    self.pinpadVC = [[PPPinPadViewController alloc] init];
    self.pinpadVC.pinTitle = @"user pin";
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:[UserTableViewCell reuseIdentifier]];
    self.pinpadVC.view.backgroundColor = C_CLEAR;
    self.pinpadVC.backgroundColor = C_CLEAR;
    self.pinpadVC.delegate = self;
    
    self.popoverPinView = [[PopOverView alloc] initWithContentView:self.pinpadVC.view];
    [self.view addSubview:self.popoverPinView];
    [self.popoverPinView fill];
    [self.popoverPinView hide];
    
    [self fetchAllUsers];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView fillInsets:inset(20)];
}


- (void)fetchAllUsers{
    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
      
        self.users = objects;
        [self.tableView reloadData];
        
    }];
    
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UserTableViewCell cellHeight];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Users";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *userCell = (UserTableViewCell *)cell;
    userCell.user = self.users[indexPath.row];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.popoverPinView show];
}


#pragma mark - Pin pad

- (void)pinPadSuccessPin{
    
    
    [ABFOBAppDelegate showMainScreen];
}

- (void)checkPin:(NSString *)pin withResultBlock:(void (^)(BOOL))resultBlock{
    
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    User *user = self.users[selectedPath.row];
    [PFUser logInWithUsernameInBackground:user.username
                                 password:pin
                                    block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                       
                                        if(error){
                                            LOGERR(error);
                                            resultBlock(NO);
                                        }
                                        else if(user){
                                            resultBlock(YES);
                                        }
                                    }];
}

- (NSInteger)pinLenght{
    return 4;
}


- (void)pinPadWillHide{
    [self.popoverPinView hide];
}
@end
