//
//  EventDetailsView.m
//  ABFOB
//
//  Created by Zac Adams on 16/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventDetailsView.h"


#import "TagableView.h"

@interface EventDetailsView()

// Left column
@property (nonatomic, strong) UIView *detailsViewContainer;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *dateTimeLabel;

// Right column
@property (nonatomic, strong) UIView *pricingDetailsViewContainer;
@property (nonatomic, strong) UILabel *stockLabel;
@property (nonatomic, strong) UILabel *chargeRateLabel;
@property (nonatomic, strong) UILabel *bondRateLabel;


// Tags
@property (nonatomic, strong)  TagableView *tagView;

@end

@implementation EventDetailsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        // Details container
        self.detailsViewContainer = [[UIView alloc] initInSuperview:self];
        
        // Name
        self.nameLabel = [[UILabel alloc]  initInSuperview:self.detailsViewContainer];
        self.nameLabel.text = @"Name";
        self.nameLabel.font = TITLE_FONT_OF_SIZE(20);
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        
        // Location
        self.locationLabel = [[UILabel alloc]  initInSuperview:self.detailsViewContainer];
        self.locationLabel.text = @"Location";
        self.locationLabel.font = SECONDARY_FONT_SIZE(15);
        self.locationLabel.textAlignment = NSTextAlignmentLeft;
        
        // Date & time
        self.dateTimeLabel = [[UILabel alloc]  initInSuperview:self.detailsViewContainer];
        self.dateTimeLabel.text = @"Date & time";
        self.dateTimeLabel.font = TITLE_FONT_OF_SIZE(15);
        self.dateTimeLabel.textAlignment = NSTextAlignmentLeft;
        
        
        // Pricing details
        self.pricingDetailsViewContainer = [[UIView alloc] initInSuperview:self];
        
        // Charge rate
        self.stockLabel = [[UILabel alloc]  initInSuperview:self.pricingDetailsViewContainer];
        self.stockLabel.text = @"?x Bean bags";
        self.stockLabel.font = TITLE_FONT_OF_SIZE(20);
        self.stockLabel.textAlignment = NSTextAlignmentLeft;
        
        // Location
        self.chargeRateLabel = [[UILabel alloc]  initInSuperview:self.pricingDetailsViewContainer];
        self.chargeRateLabel.text = @"$0.0 per bag";
        self.chargeRateLabel.font = SECONDARY_FONT_SIZE(15);
        self.chargeRateLabel.textAlignment = NSTextAlignmentLeft;
        
        // Date & time
        self.bondRateLabel = [[UILabel alloc]  initInSuperview:self.pricingDetailsViewContainer];
        self.bondRateLabel.text = @"$0.00 per 2x bags";
        self.bondRateLabel.font = TITLE_FONT_OF_SIZE(15);
        self.bondRateLabel.textAlignment = NSTextAlignmentLeft;
        
        
        // Tags
        self.tagView = [[TagableView alloc] initInSuperview:self];
        
        
        self.layer.borderWidth = 1.0f/SCREEN_SCALE;
        self.layer.borderColor = C_LIGHT_GRAY.CGColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // Layout the tags spanning across the bottom
    [self.tagView setEdge:UIViewEdgeBottom length:30];
    
    // Layout event details
    [self.detailsViewContainer setEdge:UIViewEdgeLeft length:self.width/2 insets:inset_bottom(self.tagView.height)];
    for (UIView *subview in self.detailsViewContainer.subviews){
        subview.size = s(self.detailsViewContainer.width, 20);
    }
    [self.detailsViewContainer stackSubviewsAgainstEdge:UIViewEdgeTop insets:i(5, 5, 0, 5) spacing:5];
    
    // Layout pricing details
    [self.pricingDetailsViewContainer setEdge:UIViewEdgeRight length:self.width/2 insets:inset_bottom(self.tagView.height)];
    for (UIView *subview in self.pricingDetailsViewContainer.subviews){
        subview.size = s(self.pricingDetailsViewContainer.width, 20);
    }
    [self.pricingDetailsViewContainer stackSubviewsAgainstEdge:UIViewEdgeTop insets:i(5, 5, 0, 5) spacing:5];
}

- (void)setEvent:(Event *)event{
    _event = event;
    
    [self.tagView clear];
    
    // Name
    self.nameLabel.text = event.name;
    if(self.event.pricingModel){
        self.chargeRateLabel.text = string(@"$%0.2f Per bag",event.pricingModel.chargeRate);
        self.bondRateLabel.text = string(@"$%0.2f Per %dx bags",event.pricingModel.bondRate, event.pricingModel.beanBagsPerBondCharge);
    }
    
    // Stock
    self.stockLabel.text = string(@"%dx Bean bags", event.stock);
    
    
    if(event.active){
        [self.tagView addTag:@"Active"];
    }
    
    if(event.lets){
        
        [[event.lets query] findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
            NSUInteger lets = 0;
            for(Let *let in objects){
                lets += let.stockLet;
            }
            
            [self.tagView addTag:string(@"%dx Lets", lets )];
        }];
    }
    
    
    
}


@end
