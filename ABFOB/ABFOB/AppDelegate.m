//
//  AppDelegate.m
//  ABFOB
//
//  Created by Zac Adams on 29/12/15.
//  Copyright © 2015 ABagFullOfBeans. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "CheckedOutViewController.h"
#import "PickUpsViewController.h"
#import "SettingsViewController.h"
#import "EventsViewController.h"
#import "NewLetViewController.h"
#import "CreateLetButton.h"
#import "DummyViewController.h"
#import "LoginViewController.h"
#import "StatsViewController.h"

#define CREATE_LET_BUTTON_SIZE s(50, 50)

@interface AppDelegate ()<NewLetViewControllerDelegate>

@property (nonatomic, strong) NewLetViewController *createLetViewController;
@property (nonatomic, strong) TabBarViewController *tabBarViewController;
@property (nonatomic, strong) CreateLetButton *createLetButton;

@end

@implementation AppDelegate


- (void)setupParse{
    
    [Event registerSubclass];
    [Year registerSubclass];
    [Transaction registerSubclass];
    [Let registerSubclass];
    [Customer registerSubclass];
    [Refund registerSubclass];
    [User registerSubclass];
    [PricingModel registerSubclass];
    [EventPricingModel registerSubclass];
    
    [Parse setApplicationId:@"V0DtO2wjNKrPQFr5lWcV2UQFAGHD9qu21tD4GAKE"
                  clientKey:@"pWnXfOu0bpaTusYYtGfeAlRq0LW83zQ1TzzTYx2t"];
    
    
    [UserManager singleton];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self setupParse];
    
    
    if([PFUser currentUser] == nil){
        [self showLoginScreen];
    }
    else{
        [self showMainScreen];
    }
 
    return YES;
}


- (void)showLoginScreen{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
}


- (void)showMainScreen{
    
    self.tabBarViewController = [[TabBarViewController alloc] init];
//    self.tabBarViewController.viewControllers = @[
//                                             [[CheckedOutViewController alloc] init],
//                                             [[StatsViewController alloc] init],
//                                             [[NewLetViewController alloc] init],
//                                             [[EventsViewController alloc] init],
//                                             [[SettingsViewController alloc] init]
//                                             ];

    self.tabBarViewController.viewControllers = @[
                                                  [[UINavigationController alloc] initWithRootViewController:[[CheckedOutViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[StatsViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[NewLetViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[EventsViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]]
                                                  ];
    
    self.window.rootViewController = self.tabBarViewController;
    
//    self.createLetButton = [[CreateLetButton alloc] initInSuperview:self.tabBarViewController.view edge:UIViewEdgeBottom size:CREATE_LET_BUTTON_SIZE];
//    self.createLetButton.centerY = self.tabBarViewController.tabBarView.centerY;;
//    self.self.createLetButton.centerX = self.tabBarViewController.view.centerX;
//    self.createLetButton.backgroundColor = C_RED;
//    
//    [self.createLetButton addTarget:self action:@selector(createLet)];
//    
//    
//    
//    self.createLetViewController = [[NewLetViewController alloc] init];
//    [self.tabBarViewController addChildViewController:self.createLetViewController];
//    //    [tabBarViewController.view addSubview:self.createLetViewController.view];
//    [self.tabBarViewController.view insertSubview:self.createLetViewController.view belowSubview:self.tabBarViewController.tabBarView];
//    self.createLetViewController.view.hidden = YES;
//    
//    [self.createLetViewController.view fillInsets:i(0, 0, self.tabBarViewController.tabBarView.height, 0)];
//    self.createLetViewController.delegate = self;
}

- (void)createLet{
    
    if(NO == self.createLetButton.open){
        self.createLetViewController.view.hidden = NO;
    }
    
    self.tabBarViewController.tabInteractionEnabled = self.createLetButton.open;
    
    [UIView animateWithDuration:0.3f
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.9f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
        if(self.createLetButton.open){
            self.createLetViewController.view.y = self.createLetViewController.view.height;
            self.createLetButton.rotation = (0);
        }
        else{
            self.createLetButton.rotation = RADIANS(45);
            self.createLetViewController.view.y = 0;
        }
        
    } completion:^(BOOL finished) {
        self.createLetButton.open = !self.createLetButton.open;
        self.createLetViewController.view.hidden = !self.createLetButton.open;
        
        [self.createLetViewController clear];
    }];
    
    
}


- (void)didCompleteNewLet{
    [self createLet];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.abagfullofbeans.ABFOB" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ABFOB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ABFOB.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
