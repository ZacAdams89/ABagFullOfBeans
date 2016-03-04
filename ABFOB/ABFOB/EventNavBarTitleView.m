//
//  EventNavBarTitleView.m
//  ABFOB
//
//  Created by Zac Adams on 2/03/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventNavBarTitleView.h"

@interface EventNavBarTitleView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation EventNavBarTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //
        self.nameLabel = [[UILabel alloc] initInSuperview:self];
        self.nameLabel.font = FONT_OF_SIZE(15);
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.text = @"Title";
        self.nameLabel.size = s(self.width, 15);
        
        //
        self.locationLabel = [[UILabel alloc] initInSuperview:self];
        self.locationLabel.font = FONT_OF_SIZE(10);
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
        self.locationLabel.text = @"Location";
        self.locationLabel.size = s(self.width, 10);
        
        //
        self.timeLabel = [[UILabel alloc] initInSuperview:self];
        self.timeLabel.font = FONT_OF_SIZE(10);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.text = @"Time";
        self.timeLabel.size = s(self.width, 10);
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self stackSubviewsAgainstEdge:UIViewEdgeTop];
}

- (void)setEvent:(Event *)event{
    _event = event;
    self.nameLabel.text = event.name;
//    self.locationLabel.text =
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle  = NSDateFormatterMediumStyle;
    
    
    self.timeLabel.text = [formatter stringFromDate:event.date];
}

@end
