//
//  GroupTableViewCellFrame.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCellFrame.h"
#import "DPGroupChatMessage.h"
#import "ChatDataProxy.h"
#import "UserDataProxy.h"

@interface GroupChatTableViewCellFrame : UIView

@property (nonatomic, readonly) ChatMessageType messageType;
@property (nonatomic, readonly) CGRect rectIcon;
@property (nonatomic, readonly) CGRect rectContentBg;
@property (nonatomic, retain, readonly) DPGroupChatMessage *chatMessage;
@property (nonatomic, readonly) CGFloat cellHeight; //
@property (nonatomic, retain, readonly) UIView *viewContent;

- (void)setMsgType:(ChatMessageType)type withMsg:(DPGroupChatMessage *)dpChatMessage;

@end
