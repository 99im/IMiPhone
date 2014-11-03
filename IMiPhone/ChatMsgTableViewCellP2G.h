//
//  ChatMsgTableViewCellP2G.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPGroupChatMessage.h"
#import "DPUser.h"
#import "UserDataProxy.h"
#import "SysMsgTableViewDefaultCell.h"
#import "GroupDataProxy.h"

@interface ChatMsgTableViewCellP2G : SysMsgTableViewDefaultCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblLastMsg;

- (void)drawCellBody:(DPGroupChatMessage *)dpGroupChatMsg;

@end
