//
//  LetPickUpViewController.m
//  ABFOB
//
//  Created by Zac Adams on 5/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetPickUpViewController.h"
#import "LetDetailsView.h"

@interface LetPickUpViewController ()

@property (nonatomic, strong) Let *let;
@property (nonatomic, strong) LetDetailsView *detailsView;
@property (nonatomic, strong) UIButton *checkOutButton;

@end


@implementation LetPickUpViewController

- (instancetype)initWithLet:(Let *)let
{
    self = [super init];
    if(self){
        self.let = let;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = C_WHITE;
    
    self.detailsView = [[LetDetailsView alloc] initInSuperview:self.view];
    self.detailsView.let = self.let;
    
    
    self.checkOutButton = [[UIButton alloc] initInSuperview:self.view];
    self.checkOutButton.backgroundColor = C_LIGHT_GRAY;
    [self.checkOutButton setTitle:@"Check out" forState:UIControlStateNormal];
    self.checkOutButton.titleLabel.font = FONT_OF_SIZE(20);
    
    [self.checkOutButton addTarget:self action:@selector(checkOutLet)];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.detailsView setEdge:UIViewEdgeTop length:100 insets:inset_top(20)];
    [self.checkOutButton setEdge:UIViewEdgeTop length:50 insets:inset_top(self.detailsView.bottom + 20)];
}


- (void)checkOutLet{
    
}

@end
