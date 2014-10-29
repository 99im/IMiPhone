//
//  FriendListTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendTableViewCellUser.h"

@interface FriendTableViewCellUser ()

@property (nonatomic, retain) UITapGestureRecognizer *tap;

@end



@implementation FriendTableViewCellUser

@synthesize tap;
@synthesize data;

- (void)awakeFromNib {
    // Initialization code
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self addGestureRecognizer:tap];
//    self.imgViewPortrait.userInteractionEnabled = YES;
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapHandler:(UITapGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_FRIEND_TABLE_VIEW_CELL_USER_TOUCH_PORTRAIT object:self.data];
}

@end
