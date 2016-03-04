//
//  EventsViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 9/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "EventsViewController.h"
#import "EventCollectionViewCell.h"
#import "CollectionHeaderCollectionViewCell.h"
#import "EventViewController.h"


typedef NS_ENUM(NSInteger, EventSection){
    EventSectionToday,
    EventSectionFuture,
    EventSectionPast,
    EventSectionCount,
};

@interface EventsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, EventManagerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

// Today
@property (nonatomic, strong) NSArray *todaysEvents;

// Future events
@property (nonatomic, strong) NSArray * futureEvents;


// Past events
@property (nonatomic, strong) NSArray *pastEvents;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = C_WHITE;
    self.title = @"Events";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Events" image:[UIImage imageNamed:@"events"] tag:4];
    
    // Event collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [EventCollectionViewCell cellSize];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = [CollectionHeaderCollectionViewCell cellSize];
    
    //
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = C_CLEAR;
    
    [self.collectionView registerClass:[EventCollectionViewCell class]
             forCellWithReuseIdentifier:[EventCollectionViewCell reuseIdentifier]];
    
    [self.collectionView registerClass:[CollectionHeaderCollectionViewCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[CollectionHeaderCollectionViewCell reuseIdentifier]];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView fill];
    
    
    
    [[EventManager singleton] addDelegate:self];
}


- (TabItem *)tabItem{
    TabItem *tabItem = [super tabItem];
    if(nil == tabItem){
        tabItem = [TabItem tabItemWithTitle:@"Events"
                                      image:[UIImage imageNamed:@"events"]
                           andSelectedImage:[UIImage imageNamed:@"events-selected"]];
        self.tabItem = tabItem;
    }
    
    return tabItem;
}



#pragma mark - Collection view data source


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return EventSectionCount;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    NSInteger count = 0;
    
    switch (section) {
        case EventSectionToday:
            count = [[EventManager singleton] todaysEvents].count;
            break;
            
        case EventSectionPast:
            count = [[EventManager singleton] pastEvents].count;
            break;
            
        case EventSectionFuture:
            count = [[EventManager singleton] futureEvents].count;
            break;
            
        default:
            break;
    }
    
    
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EventCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = [self eventAtIndexPath:indexPath];
    EventCollectionViewCell *eventCell = (EventCollectionViewCell *)cell;
    eventCell.event = event;
}


- (Event *)eventAtIndexPath:(NSIndexPath *)indexPath{
   
    Event *event = nil;
    switch (indexPath.section) {
        case EventSectionToday:
            event = [EventManager singleton].todaysEvents[indexPath.item];
            break;
            
        case EventSectionPast:
            event = [EventManager singleton].pastEvents[indexPath.item];
            break;
            
        case EventSectionFuture:
            event = [EventManager singleton].futureEvents[indexPath.item];
            break;
            
        default:
            break;
    }
    
    return event;
}


#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // Open event details
    
    Event *event = [self eventAtIndexPath:indexPath];
    EventViewController *eventViewController = [[EventViewController alloc] initWithEvent:event];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:eventViewController];
    [self presentViewController:navVC animated:YES completion:nil];
    
}

#pragma mark - Event manager delegate

- (void)eventManager:(EventManager *)eventManager didLoadFutureEvents:(NSArray *)events{
    [self.collectionView reloadData];
}

- (void)eventManager:(EventManager *)eventManager didLoadPastEvents:(NSArray *)events{
    [self.collectionView reloadData];
}

- (void)eventManager:(EventManager *)eventManager didLoadTodaysEvents:(NSArray *)events{
  [self.collectionView reloadData];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderCollectionViewCell *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[CollectionHeaderCollectionViewCell reuseIdentifier] forIndexPath:indexPath];

        NSString *title = [self titleForSection:indexPath.section];
        headerView.title = title;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (NSString *)titleForSection:(NSInteger)section{
    switch (section) {
        case EventSectionToday:
            return @"On today";
            break;
            
        case EventSectionFuture:
            return @"Future";
            break;
            
        case EventSectionPast:
            return @"Past";
            break;
            
        default:
            break;
    }
    
    return @"Section needs a name!";
}

#pragma mark - Collection view delegate


@end
