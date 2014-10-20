//
//  FriendListTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOTIFY_FRIEND_TABLE_VIEW_CELL_USER_TOUCH_PORTRAIT @"notify_friend_table_view_cell_user_touch_portrait"

@interface FriendTableViewCellUser : UITableViewCell <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblNick;
@property (weak, nonatomic) IBOutlet UILabel *lblGenderAndAge;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceAndTime;

@property (weak, nonatomic) id data;

@end
