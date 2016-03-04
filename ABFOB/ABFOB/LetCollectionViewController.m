//
//  LetTableViewController.m
//  ABFOB
//
//  Created by Zac Adams on 2/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetCollectionViewController.h"
#import "LetCollectionViewCell.h"
#import "LetPickUpViewController.h"
#import "ReturnLetViewController.h"

@interface LetCollectionViewController()<UISearchBarDelegate, ReturnLetViewControllerDelegate>

@property (nonatomic, strong) NSArray *lets;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayoutFlow;

// Search
@property (nonatomic, strong) UISearchBar *searchBarView;
@property (nonatomic, strong) UILabel *searchSummaryLabel;
@property (nonatomic, strong) UIButton *searchAllButton;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) PFQuery *activeFetchQuery;

// Gestures
@property (nonatomic, strong) UITapGestureRecognizer *dismissKeyboardTapRecog;

@end

@implementation LetCollectionViewController

- (instancetype)initWithLetType:(LetType)letType
{
    self = [super initWithCollectionViewLayout:self.collectionLayoutFlow];
    if(self){
        
        _letType = letType;
        [self.collectionView registerClass:[LetCollectionViewCell class] forCellWithReuseIdentifier:[LetCollectionViewCell reuseIdentifier]];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Top search bar
    self.searchBarView = [[UISearchBar alloc] initInSuperview:self.view];
    self.searchBarView.placeholder = @"Name or Mobile #";
    self.searchBarView.delegate = self;
    
    // Search summary
    self.searchSummaryLabel = [[UILabel alloc] initInSuperview:self.view];
    self.searchSummaryLabel.font = FONT_OF_SIZE(15);
    self.searchSummaryLabel.textAlignment = NSTextAlignmentLeft;

    // Clear / dismiss search button
    self.clearButton = [[UIButton alloc] initInSuperview:self.view];
    [self.clearButton addTarget:self action:@selector(clearSearch)];
    self.clearButton.backgroundColor = C_LIGHT_GRAY;
    [self.clearButton setTitle:@"Show all" forState:UIControlStateNormal];
    self.clearButton.layer.cornerRadius = 5;
    self.clearButton.titleLabel.font =FONT_OF_SIZE(10);
    self.clearButton.hidden = YES;

    //
    self.collectionView.backgroundColor = C_WHITE;
    
    
    // Fetch the content
    [self fetchAllLets];
    
    // Add a tap gesture to remove the keyboard when the content is tapped.
    self.dismissKeyboardTapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.dismissKeyboardTapRecog];
    self.dismissKeyboardTapRecog.enabled = NO; // Disabled while the keyboard is not shown.
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    // Search bar banks to the top of the screen.
    [self.searchBarView setEdge:UIViewEdgeTop length:40];
    
    //
    [self.clearButton setCorner:UIViewCornerTopRight size:s(60, 20) insets:i(self.searchBarView.bottom + 10, 20, 0 , 0)];
    
    // Search summary shown beneath the search bar.
    [self.searchSummaryLabel setEdge:UIViewEdgeTop length:20 insets:i(self.searchBarView.bottom + 10, 0, 0, 10)];
    
    // Content fills the remainder of the screen.
    [self.collectionView fillInsets:inset_top(self.searchSummaryLabel.bottom + 10)];
}


- (void)clearSearch{
    
    self.lets = nil;
    [self.collectionView reloadData];
    self.searchSummaryLabel.text = @"No search applied";
    self.clearButton.hidden = YES;
    self.searchBarView.text = @"";
//    [self.searchBarView endEditing:YES];
    
    [self fetchAllLets];
}

- (void)setLets:(NSArray *)lets{
    _lets = lets;
    [self.collectionView reloadData];
}


- (void)updateLetCount{
}

- (void)fetchAllLets{

    self.searchAllButton.hidden = YES;
    self.searchSummaryLabel.text = @"Showing All";
    self.searchBarView.text = @"";
    
    self.activeFetchQuery = [PFQuery queryWithClassName:[Let parseClassName]];
    [self.activeFetchQuery whereKey:@"status" equalTo:[NSNumber numberWithInt:self.letType]];
    [self.activeFetchQuery includeKey:@"customer"];
    [self.activeFetchQuery includeKey:@"transaction"];
    [self.activeFetchQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        if(error){
            LOGERR(error);
        }
        else{
            LOGSTAR(@"Found lets : %@", objects);
            self.lets = objects;
        }
        
        self.activeFetchQuery = nil;
    }];
    
}


- (void)fetchLetsWithSearchString:(NSString *)searchString{
    
//    self.searchAllButton.hidden = NO;
    self.clearButton.hidden = NO;
    
    self.searchSummaryLabel.text = string(@"Showing all for \"%@\"",searchString);
    
    // We are searching for lets associated with customers
    PFQuery *customerNameQuery = [PFQuery queryWithClassName:[Customer parseClassName]];
    [customerNameQuery whereKey:@"firstName" matchesRegex:searchString  modifiers:@"i"];
    
    PFQuery *customerMobieQuery = [PFQuery queryWithClassName:[Customer parseClassName]];
    [customerMobieQuery whereKey:@"mobile" containsString:searchString];
    
    PFQuery *customerQuery = [PFQuery orQueryWithSubqueries:@[customerMobieQuery, customerNameQuery]];
    
    
    // Search for a let based on its customers details
    self.activeFetchQuery = [PFQuery queryWithClassName:[Let parseClassName]];
    [self.activeFetchQuery whereKey:@"status" equalTo:[NSNumber numberWithInt:self.letType]];
    [self.activeFetchQuery whereKey:@"customer" matchesQuery:customerQuery];
    [self.activeFetchQuery includeKey:@"customer"];
    [self.activeFetchQuery includeKey:@"transaction"];
    
    [self.activeFetchQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        if(error){
            LOGERR(error);
        }
        else{
            
            self.searchSummaryLabel.text = string(@"Showing all for \"%@\"(%d)",searchString, objects.count);
            
            LOGSTAR(@"Found lets : %@", objects);
            self.lets = objects;
        }
        
        self.activeFetchQuery = nil;
    }];
}

//
- (void)dismissKeyboard{
    [self.searchBarView endEditing:YES];
}


#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.lets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LetCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LetCollectionViewCell *letCell = (LetCollectionViewCell *)cell;
    letCell.let = [self.lets objectAtIndex:indexPath.row];
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Let *let = [self.lets objectAtIndex:indexPath.item];
    
    switch (let.status) {
        case LetStateAwaitingPickUp:
            [self openPickUpViewForLet:let];
            break;
            
        case LetStateCheckedOut:
            [self openReturnViewForLet:let];
            break;
            
        default:
            break;
    }
    
}

- (void)openPickUpViewForLet:(Let *)let{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:string(@"%@ for %@", let.transaction.quantityString, let.customer.firstName) message:@"What do you want to do with the pick up" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *checkOutAction = [UIAlertAction actionWithTitle:@"Checkout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[LetManager singleton] checkoutLet:let];
        
        [self removeLet:let];
    }];
    
    
    UIAlertAction *cancelPickUp = [UIAlertAction actionWithTitle:@"Cancel pickup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Delete the pick up
        [[LetManager singleton] cancelLet:let];
        [self removeLet:let];
    }];
    
    UIAlertAction *cancelActions = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Cancel the actions
    }];
    
    
    [alert addAction:checkOutAction];
    [alert addAction:cancelPickUp];
    [alert addAction:cancelActions];
    
    if(IS_PAD){
    
        [alert setModalPresentationStyle:UIModalPresentationPopover];
        
        UIPopoverPresentationController *popPresenter = [alert
                                                         popoverPresentationController];
        
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
        
        popPresenter.sourceView = cell;
        popPresenter.sourceRect = cell.bounds;
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)removeLet:(Let *)let{
    // Reload the data
    NSMutableArray *lets = [self.lets mutableCopy];
    [lets removeObject:let];
    self.lets = lets;
    [self.collectionView reloadData];
}

- (void)openReturnViewForLet:(Let *)let{
    
    ReturnLetViewController *returnLetViewController = [[ReturnLetViewController alloc] init];
    returnLetViewController.let = let;
    returnLetViewController.delegate = self;
    [self presentViewController:returnLetViewController animated:YES completion:nil];
    
}



#pragma mark - Collection view flow layout - Lazy loading

- (UICollectionViewFlowLayout *)collectionLayoutFlow{
    
    if(nil == _collectionLayoutFlow){
        _collectionLayoutFlow = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayoutFlow.itemSize = [LetCollectionViewCell cellSize];
        _collectionLayoutFlow.minimumInteritemSpacing = 10;
        
        if(IS_PAD){
            _collectionLayoutFlow.minimumLineSpacing = 10;
        }
        else{
            _collectionLayoutFlow.minimumLineSpacing = 0l;
        }
    }
    
    return _collectionLayoutFlow;
}


#pragma mark - Search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.dismissKeyboardTapRecog.enabled = YES; // Keyboard is shown, activate the dismissal tap.
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.dismissKeyboardTapRecog.enabled = NO; // No longer editing, disable the dissmisal gesture.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // Perform search
    [self fetchLetsWithSearchString:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    // Cancel search
    [self fetchAllLets];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    // Search has been updated, cancel any active queries
    if(self.activeFetchQuery){
        [self.activeFetchQuery cancel];
    }
    
    
    if(searchText.length){
        // Query with the search text
        [self fetchLetsWithSearchString:searchText];
    }
    else{
        // Empty search field, fetch all lets.
        [self clearSearch];
    }
}


#pragma mark - Return let view controller delegate

- (void)didReturnLet:(Let *)let{
    [self removeLet:let];
}

@end
