//
//  LetTableViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 2/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "LetCollectionViewCell.h"
#import "LetDetailsView.h"

@interface LetCollectionViewCell ()

// Let details
@property (nonatomic, strong) LetDetailsView *letDetailsView;

@end

@implementation LetCollectionViewCell


+ (CGSize)cellSize{
    if(IS_PAD){
        return s(375 , 110);
    }
    else{
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        return s(screenWidth, 110);
    }
}

+ (NSString *)reuseIdentifier{
    return @"LetCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        
        self.letDetailsView = [[LetDetailsView alloc] initInSuperview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.letDetailsView fill];
}

- (void)setLet:(Let *)let{
    _let = let;
    self.letDetailsView.let = let;
}

@end
