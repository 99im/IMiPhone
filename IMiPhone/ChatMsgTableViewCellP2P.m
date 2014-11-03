//
//  ChatMsgTableViewCellP2P.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMsgTableViewCellP2P.h"
#import "UserDataProxy.h"

@implementation ChatMsgTableViewCellP2P

- (void)drawCellBody:(DPChatMessage *)dpChatMsg;
{
    DPUser *dpUser;
    long long herUid;
    if (dpChatMsg.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        herUid = dpChatMsg.targetId;
    }
    else {
        herUid = dpChatMsg.senderUid ;
    }
    dpUser = [[UserDataProxy sharedProxy] getUserByUid:herUid];
    if (dpUser) {
        self.lblTitle.text = dpUser.nick;
        
    }
    //        NSLog(@"%@,%@",dpChatMsg.content,dpChatMsg.sendTime);
    self.lblLastMsg.text = dpChatMsg.content;
    self.lblTime.text = dpChatMsg.sendTime;
}

@end
