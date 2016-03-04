//
//  PopOverContentView.m
//  ABFOB
//
//  Created by Zac Adams on 26/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "PopOverContentView.h"
#import "PopOverView.h"

const CGFloat kContentTitleHeight = 40;

@interface PopOverContentView ()

@property (nonatomic, strong) UIView *titleViewContainer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIView *topLineSeperatorView;

@end


@implementation PopOverContentView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        //
        self.titleViewContainer = [[UIView alloc] initInSuperview:self];
        
        // Title
        self.titleLabel = [[UILabel alloc] initInSuperview:self.titleViewContainer];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = FONT_OF_SIZE(20);
        self.titleLabel.textColor = C_BLACK;
        self.titleLabel.text = @"Title";
        
        // Cancel
        self.cancelButton = [[UIButton alloc] initInSuperview:self.titleViewContainer];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = SECONDARY_FONT_SIZE(15);
        self.cancelButton.textColor = C_BLACK;
        [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        //Done
        self.doneButton = [[UIButton alloc] initInSuperview:self.titleViewContainer];
        [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
        self.doneButton.titleLabel.font = SECONDARY_FONT_SIZE(15);
        self.doneButton.textColor = C_BLACK;
        [self.doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
        // Content view
        self.contentView = [[UIView alloc] initInSuperview:self];
        
        // Top seperator
        self.topLineSeperatorView = [[UIView alloc] initInSuperview:self];
        self.topLineSeperatorView.backgroundColor = C_LIGHT_GRAY;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // Layout the title bar
    [self.titleViewContainer setEdge:UIViewEdgeTop length:kContentTitleHeight];
    [self.cancelButton setEdge:UIViewEdgeLeft length:100 insets:inset_left(20)];
    [self.doneButton setEdge:UIViewEdgeRight length:100 insets:inset_right(20)];
    [self.titleLabel setEdge:UIViewEdgeTop length:self.titleViewContainer.height insets:i(0, self.doneButton.distanceRight + self.doneButton.width, 0, self.cancelButton.right)];
    
    
    // Fill in the content view
    [self.contentView fillInsets:inset_top(self.titleViewContainer.bottom)];
    
    // Top seperator
    [self.topLineSeperatorView setEdge:UIViewEdgeTop length:1.0f/SCREEN_SCALE];
}


- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}


- (void)done{
    PopOverView *popOverView = (PopOverView *)self.superview;
    [popOverView hide];
}

- (void)cancel{
    PopOverView *popOverView = (PopOverView *)self.superview;
    [popOverView hide];
}

- (void)setShowDoneButton:(BOOL)showDoneButton{
    _showDoneButton = showDoneButton;
    self.doneButton.hidden = !showDoneButton;
}

@end
