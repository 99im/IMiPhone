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
- (IBAction)cancelFocusTouchUp:(id)sender {
  if (self.isFocused == YES) {
    // NSLog(@"cancelFocus : %i", self.UserId);
    [[FriendMessageProxy sharedProxy] sendTypeFocusCancel:self.userId];
  } else {
    [[FriendMessageProxy sharedProxy] sendTypeFocusAdd:self.userId];
  }
}

- (void)fillWithIndexPath:(NSIndexPath *)indexPath {
  // NSArray *listUserInfo;
  NSObject *user;
  NSObject *uinfo;
  NSInteger isFriend;
  NSInteger row = indexPath.row;
  uint currUserListType = [FriendDataProxy sharedProxy].currUserListType;
  if (currUserListType == USER_LIST_FOR_FOCUS) {
    // listUserInfo = [FriendDataProxy sharedProxy].listMyFocus;
    user = [[FriendDataProxy sharedProxy].listMyFocus objectAtIndex:row];
    uinfo = [user valueForKey:KEYP__FRIEND_FOCUS_LIST__LIST_UINFO];

    // TODO : define KEYP__FRIEND_FAN_LIST__LIST_UINFO_NICK
    self.nickName =
        [uinfo valueForKey:KEYP__FRIEND_FRIEND_LIST__LIST_UINFO_NICK];
    // TODO : define KEYP__FRIEND_FAN_LIST__LIST_UINFO_UID
    self.userId = [uinfo valueForKey:KEYP__FRIEND_FRIEND_LIST__LIST_UINFO_UID];
    self.isFocused = YES;
  } else if (currUserListType == USER_LIST_FOR_FANS) {
    // listUserInfo = [FriendDataProxy sharedProxy].listMyFans;
    user = [[FriendDataProxy sharedProxy].listMyFans objectAtIndex:row];
    uinfo = [user valueForKey:KEYP__FRIEND_FAN_LIST__LIST_UINFO];

    // TODO : define KEYP__FRIEND_FAN_LIST__LIST_UINFO_NICK
    self.nickName =
        [uinfo valueForKey:KEYP__FRIEND_FRIEND_LIST__LIST_UINFO_NICK];
    // TODO : define KEYP__FRIEND_FAN_LIST__LIST_UINFO_UID
    self.userId = [uinfo valueForKey:KEYP__FRIEND_FRIEND_LIST__LIST_UINFO_UID];

    // NSLog(@"%s",typeof([user
    // valueForKey:KEYP__FRIEND_FAN_LIST__LIST_ISFRIENDS]));

    isFriend =
        [[user valueForKey:KEYP__FRIEND_FAN_LIST__LIST_ISFRIENDS] integerValue];

    if (isFriend == 1) {
      self.isFocused = YES;
    } else {
      self.isFocused = NO;
    }
  }

  NSLog(@"row %li  \nisFocused:%i : %li  \n%@ uinfo: \n%@\n======\n", row,
        self.isFocused, isFriend, user, uinfo);
  self.LblUserName.text = self.nickName;
  if (self.isFocused == YES) {
    [self.BtnFocusOrCancel setTitle:@"取消关注" forState:UIControlStateNormal];
    [self.BtnFocusOrCancel setTitle:@"取消关注"
                           forState:UIControlStateSelected];
  } else {
    [self.BtnFocusOrCancel setTitle:@"关注TA" forState:UIControlStateNormal];
    [self.BtnFocusOrCancel setTitle:@"关注TA" forState:UIControlStateSelected];
  }
}
@end
