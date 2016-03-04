//
//  UserTableViewCell.m
//  ABFOB
//
//  Created by Zac Adams on 9/01/16.
//  Copyright © 2016 ABagFullOfBeans. All rights reserved.
//

#import "UserTableViewCell.h"

@interface UserTableViewCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation UserTableViewCell

+ (CGFloat)cellHeight{
    return 50;
}

+ (NSString *)reuseIdentifier
{
    return @"UserTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.label = [[UILabel alloc] initInSuperview:self.contentView];
        self.label.text = @"text";
        self.label.font = FONT_OF_SIZE(20);
        self.label.textAlignment = NSTextAlignmentLeft;
        
        
//        self.loginButton = [[UIButton alloc] initInSuperview:self.contentView];
//        self.loginButton.backgroundColor = C_LIGHT_GRAY;
//        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
//        self.loginButton.layer.cornerRadius = 5;
//        self.loginButton.titleLabel.font = FONT_OF_SIZE(15);
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label setEdge:UIViewEdgeLeft length:self.contentView.width insets:inset_left(20)];
//    [self.loginButton setEdge:UIViewEdgeRight size:s(60, 30) insets:inset_right(20)];
}


- (void)setUser:(User *)user{
    _user = user;
    self.label.text = user.username;
}

@end
