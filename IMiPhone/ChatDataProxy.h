//
//  MessageDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMessageDAO.h"
#import "MessageGroupDAO.h"
#import "DPChatMessage.h"
#import "DPMessageGroup.h"
#import "ImDataUtil.h"

typedef enum {
    ChatViewTypeP2P = 0,
    ChatViewTypeP2G
}ChatViewType;

@interface ChatDataProxy : NSObject

@property (nonatomic) NSInteger chatViewType;
@property (nonatomic) NSInteger chatToUid;


+ (ChatDataProxy*)sharedProxy;

//此方法用key value方式访问数组。[注]修改数组中元素内容，需用数组replace操作，以触发observer的相关逻辑
- (NSMutableArray *)mutableArrayMessages;
- (NSMutableArray *)mutableArrayMessageGroups;

- (DPChatMessage *)getChatMessageFromMid:(NSInteger)mid;

@end
