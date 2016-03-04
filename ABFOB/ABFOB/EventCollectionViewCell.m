//
//  EventCollectionViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 11/02/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "EventCollectionViewCell.h"
#import "EventDetailsView.h"


@interface EventCollectionViewCell ()

@property (nonatomic, strong) EventDetailsView *eventDetailsView;

@end

@implementation EventCollectionViewCell



+ (NSString *)reuseIdentifier{
    return @"EventCollectionViewCell";
}

+ (CGSize)cellSize{

    if(IS_PAD)
        return s(375, 100);
    else
        return s([[[UIApplication sharedApplication] delegate] window].frame.size.width, 100);
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.eventDetailsView = [[EventDetailsView alloc] initFullInSuperview:self.contentView];
    }
    return self;
}


- (void)setEvent:(Event *)event{
    _event = event;
    self.eventDetailsView.event = event;
}

@end
