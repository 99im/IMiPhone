//
//  ChatMsgTableViewCellP2G.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMsgTableViewCellP2G.h"

@implementation ChatMsgTableViewCellP2G

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawCellBody:(DPGroupChatMessage *)dpGroupChatMsg
{
    long long groupid = dpGroupChatMsg.targetId;
    DPGroup *group = [[GroupDataProxy sharedProxy] getGroupInfo:groupid byHttpMode:NO];
    if (group) {
        self.lblTitle.text = group.name;
    }
    //        NSLog(@"%@,%@",dpChatMsg.content,dpChatMsg.sendTime);
    self.lblLastMsg.text = dpGroupChatMsg.content;
    self.lblTitle.text = dpGroupChatMsg.sendTime;
}

@end
