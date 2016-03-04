//
//  TabBarViewController.m
//  A Bag Full Of Beans
//
//  Created by Zac Adams on 10/12/15.
//  Copyright © 2015 A Bag Full Of Beans. All rights reserved.
//

#import "TabBarViewController.h"
#import "TabContentViewController.h"
#import "TabItemCollectionViewCell.h"
#import "AvailableStockView.h"

#define PAD_TAB_NAV_LENGHT 64
#define PHONE_TAB_NAV_LENGHT 64
#define TOP_BAR_HEIGHT 64

@interface TabBarViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *tabNavigationBarCollectionView;
@property (nonatomic, strong) UIView *disabledTabNavOverlayView;
//@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentView;

//
@property (nonatomic, strong) AvailableStockView *availableStockView;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self setupTopBarView];
    [self setupTabNavBar];
    [self setupContentView];
    [self setupStockCountView];
}


- (void)setupStockCountView{
    
//    self.availableStockView = [[AvailableStockView alloc] initInSuperview:self.topBarView edge:UIViewEdgeRight size:s(40,30) insets:i(20, 10, 10, 0)];
}

- (UIView *)tabBarView{
    return self.tabNavigationBarCollectionView;
}

#pragma mark - Layout

//- (void)setupTopBarView{
//    self.topBarView = [[UIView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:TOP_BAR_HEIGHT];
//    self.topBarView.backgroundColor = C_FADED;
//    
//    // title
//    self.titleLabel = [[UILabel alloc] initFullInSuperview:self.topBarView insets:inset_top(10)];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.font = TITLE_FONT_OF_SIZE(20);
//    self.titleLabel.textColor = C_BLACK;
//}

- (void)setupTabNavBar{
    
    // Tab item laout flow
    UICollectionViewFlowLayout *collectionCellLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionCellLayout.itemSize = [TabItemCollectionViewCell cellSize];
    collectionCellLayout.minimumInteritemSpacing = (self.view.width-(5*[TabItemCollectionViewCell cellSize].width))/5;
    collectionCellLayout.minimumLineSpacing = 10;
    
    
    // Tab nav bar
    self.tabNavigationBarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionCellLayout];
    
    // Add to view
    [self.view addSubview:self.tabNavigationBarCollectionView];
    
    // Align to the idioms resoective edge
    [self.tabNavigationBarCollectionView setEdge:[self tabNavEdgeForInterfaceIdiom] length:[self tabNavLengthForInterfaceIdiom] insets:[self tabNavInsetsForInterfaceIdiom]];
    

    // Style
    self.tabNavigationBarCollectionView.backgroundColor = C_TAB_BAR;
    
    // Content seperator
    UIView *contentSeperatorLineView = [[UIView alloc] initInSuperview:self.tabNavigationBarCollectionView edge:[self seperatorEdgeInterfaceIdiom] length:SCREEN_SCALE/2];
    contentSeperatorLineView.backgroundColor = C_FADED;
    
    
    // Configure cells
    [self.tabNavigationBarCollectionView registerClass:[TabItemCollectionViewCell class] forCellWithReuseIdentifier:[TabItemCollectionViewCell reuseIdentifier]];
    
    
    self.tabNavigationBarCollectionView.delegate = self;
    self.tabNavigationBarCollectionView.dataSource = self;
    
    if(self.viewControllers){
        [self.tabNavigationBarCollectionView reloadData];
    }
    
    
    //
    
    self.disabledTabNavOverlayView = [[UIView alloc] initFullInSuperview:self.tabNavigationBarCollectionView];
    self.disabledTabNavOverlayView.backgroundColor = [C_WHITE colorWithAlphaComponent:0.9f];
    self.disabledTabNavOverlayView.hidden = YES;
}

- (void)setupContentView{
    self.contentView = [[UIView alloc] initFullInSuperview:self.view insets:[self insetsForInterfaceIdiom]];
    self.contentView.backgroundColor = C_WHITE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabInteractionEnabled:(BOOL)tabInteractionEnabled{
    _tabInteractionEnabled = tabInteractionEnabled;
    self.tabNavigationBarCollectionView.userInteractionEnabled = tabInteractionEnabled;
    self.disabledTabNavOverlayView.hidden = tabInteractionEnabled;
}


- (void)setActiveTab:(NSInteger)tab{
    
    UIViewController *tabVC = [self.viewControllers objectAtIndex:tab];
    tabVC.view.hidden = NO;
    self.titleLabel.text = tabVC.tabBarItem.title;
}

#pragma mark - Interface idiom layouts

- (UIViewEdge)seperatorEdgeInterfaceIdiom{
  /*  if(IS_PAD){
        return UIViewEdgeRight;
    }
    else{*/
        return UIViewEdgeTop;
   // }
}

- (UIViewEdge)tabNavEdgeForInterfaceIdiom{
 /*   if(IS_PAD){
        return UIViewEdgeLeft;
    }
    else{*/
        return UIViewEdgeBottom;
    //}
}


- (UIEdgeInsets)insetsForInterfaceIdiom{
    /*if(IS_PAD){
        return i(TOP_BAR_HEIGHT, 0, 0, [self tabNavLengthForInterfaceIdiom]);
    }
    else{*/
        return i(TOP_BAR_HEIGHT, 0, [self tabNavLengthForInterfaceIdiom], 0);
    //}
}


- (NSInteger)tabNavLengthForInterfaceIdiom{
   /* if(IS_PAD){
        return PAD_TAB_NAV_LENGHT;
    }
    else{*/
        return PHONE_TAB_NAV_LENGHT;
    //}
}

- (UIEdgeInsets)tabNavInsetsForInterfaceIdiom{
    /*if(IS_PAD){
        return inset_top(TOP_BAR_HEIGHT);
    }
    else{*/
        return CGInsetsZero;
    //}
}


- (UIEdgeInsets)tabItemInsetsForInterfaceIdiom{
    /*if(IS_PAD){
        return i(0, 0, 0, 0);
    }
    else{*/
        CGFloat height = [self tabNavLengthForInterfaceIdiom];
        CGFloat itemHeight = [TabItemCollectionViewCell cellSize].height;
        CGFloat heightInsets = (height - itemHeight) / 2;
//        return i(heightInsets, 20, heightInsets, 20);
    //}
    
    return i(heightInsets, 0, heightInsets, 0);
}

- (CGInsets)insetsForContent{
    /*if(IS_PAD){
        return i(self.topBarView.bottom, 0, 0, [self tabNavLengthForInterfaceIdiom]);
    }
    else{*/
//        return i(self.topBarView.bottom, 0, [self tabNavLengthForInterfaceIdiom], 0);
    //}
    
    
//    if(IS_PAD){
//        return i(self.topBarView.bottom + 20, 20, [self tabNavLengthForInterfaceIdiom] + 20, 20);
//     }
//     else{
//            return i(self.topBarView.bottom, 0, [self tabNavLengthForInterfaceIdiom], 0);
//    }
    
    
    if(IS_PAD){
        return i(0, 20, [self tabNavLengthForInterfaceIdiom] + 20, 20);
     }
     else{
            return i(0, 0, [self tabNavLengthForInterfaceIdiom], 0);
    }
}

#pragma mark - Tab bar items

- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    
    for(UIViewController *viewController in _viewControllers){
        [self addChildViewController:viewController];
        [self.view addSubview:viewController.view];
        
        // Adjust the content of the tab to fit
        [viewController.view fillInsets:[self insetsForContent]];
        viewController.view.hidden = YES;
    }
    
    if(self.tabNavigationBarCollectionView){
        [self.tabNavigationBarCollectionView reloadData];
    }
    
    // Ensure the tab bar is on top of the content views
    [self.view bringSubviewToFront:self.tabBarView];
    
    
    // Activate the center tab. Round down
    NSInteger selectedIndex = viewControllers.count/2;
    [self setActiveTab:selectedIndex];
    [self.tabNavigationBarCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}


#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TabItemCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TabItemCollectionViewCell *tabItemCell = (TabItemCollectionViewCell *)cell;
    tabItemCell.tabItem = [self tabItemForIndexPath:indexPath];
}

- (TabItem *)tabItemForIndexPath:(NSIndexPath *)indexPath{
//    UINavigationController *nav = [self.viewControllers objectAtIndex:indexPath.row];
//    TabContentViewController *content = [nav topViewController];
    TabContentViewController *tabContentVC = [[self.viewControllers objectAtIndex:indexPath.row] topViewController];
    return tabContentVC.tabItem;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return [self tabItemInsetsForInterfaceIdiom];
}


#pragma mark - Collection view delegate 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self setActiveTab:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *tabVC = [self.viewControllers objectAtIndex:indexPath.item];
    tabVC.view.hidden = YES;
}


@end
