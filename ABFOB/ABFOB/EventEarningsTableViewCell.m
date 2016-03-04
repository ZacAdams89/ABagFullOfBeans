//
//  EventEarningsTableViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 25/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventEarningsTableViewCell.h"
#import "EventEarningSummaryView.h"

@interface EventEarningsTableViewCell ()

@property (nonatomic, strong) EventEarningSummaryView *earningsSummaryView;

@end

@implementation EventEarningsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.earningsSummaryView = [[EventEarningSummaryView alloc] initFullInSuperview:self.contentView insets:insets_x(20)];
    }
    return self;
}


+ (NSString *)reuseIdentifier{
    return @"EventEarningsTableViewCell";
}

+ (double)cellHeight{
    return 150;
}


- (void)setEvent:(Event *)event{
    _event = event;
    self.earningsSummaryView.event = event;
}

@end
