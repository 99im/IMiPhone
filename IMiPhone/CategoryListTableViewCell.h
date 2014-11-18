//
//  CategoryListTableViewCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDataProxy.h"
#import "FriendMessageProxy.h"
#import "UserDataProxy.h"

@interface CategoryListTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property(weak, nonatomic) IBOutlet UILabel *lblUserName;

- (void)fillWithDPFocusUser:(DPFocusUser *)dpFocusUser;

- (void)fillWithDPFanUser:(DPFanUser *)dpFanUser;

@end
