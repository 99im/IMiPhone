//
//  ChatMsgTableViewCellP2G.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPChatMessage.h"
#import "DPUser.h"
#import "UserDataProxy.h"

@interface ChatMsgTableViewCellP2G : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (void)drawCellBody:(DPChatMessage *)dpChatMsg;

@end
