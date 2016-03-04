//
//  AvailableStockView.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "AvailableStockView.h"

@interface AvailableStockView ()

@property (nonatomic, strong) UIImageView *beanBagImageView;
@property (nonatomic, strong) UILabel *stockAvailableCountLabel;

@end

@implementation AvailableStockView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){

        
        self.beanBagImageView = [[UIImageView alloc] initFullInSuperview:self];
        self.beanBagImageView.image = [UIImage imageNamed:@"bean-bag"];
        self.beanBagImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.stockAvailableCountLabel = [[UILabel alloc] initInSuperview:self];
        self.stockAvailableCountLabel.font = TITLE_FONT_OF_SIZE(10);
        self.stockAvailableCountLabel.backgroundColor = C_WHITE;
        self.stockAvailableCountLabel.textAlignment = NSTextAlignmentCenter;
        self.stockAvailableCountLabel.layer.cornerRadius = 2;
        self.stockAvailableCountLabel.clipsToBounds = YES;

        [[EventManager singleton].activeEvent addObserver:self forKeyPath:@"stockAvailable" options:NSKeyValueObservingOptionNew context:nil];
        [self updateAvailableStock];
        
        
        UITapGestureRecognizer *tapGestureRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshStockCount)];
        [self addGestureRecognizer:tapGestureRecog];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.stockAvailableCountLabel setEdge:UIViewEdgeBottom length:10 insets:insets_x(5)];
}


- (void)updateAvailableStock{
    self.stockAvailableCountLabel.text = string(@"%d", [EventManager singleton].activeEvent.stockAvailable);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"stockAvailable"]){
        [self updateAvailableStock];
    }
}

- (void)refreshStockCount{
    [[EventManager singleton].activeEvent fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        Event *event = (Event *)object;
        self.stockAvailableCountLabel.text = string(@"%d", event.stockAvailable);
    }];
}

@end
