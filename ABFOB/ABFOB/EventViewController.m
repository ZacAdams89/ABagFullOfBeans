//
//  EventViewController.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventViewController.h"
#import "EventEarningsTableViewCell.h"
#import "EventDetailsView.h"
#import "EventsLetsTableViewCell.h"
#import "LetCollectionViewController.h"
#import "EditEventView.h"
#import "PopOverView.h"
#import "EventNavBarTitleView.h"
#import "UINavigationBar+CustomHeight.h"


typedef NS_ENUM(NSInteger, EventSection){
    EventSectionEarningsSummary,
    EventSectionLets,
    EventSectionCount
};

@interface EventViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) EventDetailsView *detailView;
@property (nonatomic, weak) Event *event;

// Content will be served through a table view.
@property (nonatomic, strong) UITableView *tableView;

//
@property (nonatomic, strong) NSArray *lets;

// Lets cell. Created out side of the table views data source flow so as it can pre calculate its content height
@property (nonatomic, strong)  EventsLetsTableViewCell *eventsLetsTableViewCell;

// Edit popover view
@property (nonatomic, strong) PopOverView *popOverView;
@property (nonatomic, strong) EditEventView *editEventView;

@end

@implementation EventViewController

- (instancetype)initWithEvent:(Event *)event
{
    self = [super init];
    if(self){
        self.event = event;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    // Title view
    EventNavBarTitleView *eventTitleView = [[EventNavBarTitleView alloc] initWithSize:s(200, 44)];
    eventTitleView.event = self.event;
    self.navigationItem.titleView = eventTitleView;
    
    // Adjust the size of the navbar to
    [self.navigationController.navigationBar setHeight:kExtendedNavBarHeight];
    
    // Content table view
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[EventEarningsTableViewCell class] forCellReuseIdentifier:[EventEarningsTableViewCell reuseIdentifier]];
    
    // Detail view
    self.detailView = [[EventDetailsView alloc] initWithSize:s(self.view.width, 120)];
    self.detailView.event = self.event;
    self.tableView.tableHeaderView = self.detailView;
    
    //
    EditEventView *editEventView = [[EditEventView alloc] initWithSize:s(self.view.width, 300)];
    editEventView.event = self.event;
    self.popOverView = [[PopOverView alloc] initWithContentView:editEventView];
    [self.view addSubview:self.popOverView];
    [self.popOverView fill];
    [self.popOverView hide];
    
    // Set up navigation items
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                           target:self
                                                                                           action:@selector(editEvent)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(cancelAndDismiss)];
    
    
    // Load the events lets
    PFQuery *letQuery = [self.event.lets query];
    [letQuery includeKey:@"customer"];
    [letQuery includeKey:@"transaction"];
    
    [letQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.lets = objects;
        
        // Pre create the lets table cell so we can determin its height.
        self.eventsLetsTableViewCell = [[EventsLetsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EventsLetsTableViewCell reuseIdentifier]];
        self.eventsLetsTableViewCell.lets = self.lets;
        
        // Reload the tables data.
        [self.tableView reloadData];
    }];
    
    
    // Update the content display
    if(self.event)
       [self updateUI];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
//    [self.tableView fillInsets:inset_top(kExtendedNavBarHeight + kStatusBarHeight)];
    [self.tableView fill];
}

- (void)updateUI{
    self.detailView.event = self.event;
}


#pragma mark - Actions

- (void)cancelAndDismiss{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)editEvent{
    [self.popOverView show];
}


#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] initWithSize:s(tableView.width, [self tableView:tableView heightForHeaderInSection:section])];
    
    UILabel *titleLabel = [[UILabel alloc] initInSuperview:sectionView edge:UIViewEdgeLeft length:sectionView.width insets:inset_left(20)];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    titleLabel.font = FONT_OF_SIZE(15);
    return sectionView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case EventSectionEarningsSummary:
            return @"Event Earnings";
            break;
            
        case EventSectionLets:
            return @"Events Lets";
            break;
            
        default:
            break;
    }
    
    return @"Section header";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case EventSectionEarningsSummary:
            return [EventEarningsTableViewCell cellHeight];
            break;
            
        case EventSectionLets:
            return [self.eventsLetsTableViewCell contentHeight];
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.eventsLetsTableViewCell){
        return EventSectionCount;
    }
    else{
        return EventSectionCount-1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case EventSectionEarningsSummary:
            return 1;
            break;
            
        case EventSectionLets:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;

    switch (indexPath.section) {
        case EventSectionEarningsSummary:
            cell = [tableView dequeueReusableCellWithIdentifier:[EventEarningsTableViewCell reuseIdentifier] forIndexPath:indexPath];
            [self configureCell:cell forRowAtIndexPath:indexPath];
            break;
            
        case EventSectionLets:
            cell = self.eventsLetsTableViewCell;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case EventSectionEarningsSummary:{
            EventEarningsTableViewCell *earningsCell = (EventEarningsTableViewCell *)cell;
            earningsCell.event = self.event;
        }break;
            
        default:
            break;
    }
}

@end
