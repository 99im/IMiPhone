//
//  CategoryListTableViewCell.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "CategoryListTableViewCell.h"

@implementation CategoryListTableViewCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)fillWithDPFocusUser:(DPFocusUser *)dpFocusUser
{  // NSArray *listUserInfo;
    DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpFocusUser.focusUid];
    self.lblUserName.text = dpUser.nick;
}

- (void)fillWithDPFanUser:(DPFanUser *)dpFanUser
{
    DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpFanUser.fanUid];
    self.lblUserName.text = dpUser.nick;

}

@end
