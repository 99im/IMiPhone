//
//  ChatMessageProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMessageProxy.h"
#import "UserDataProxy.h"

@implementation ChatMessageProxy

static ChatMessageProxy *messageProxy = nil;

+ (ChatMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageProxy = [[self alloc] init];
    });
    return messageProxy;
}

- (void)sendTypeP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum
{
    
}

- (void)parseTypeP2PChatList:(id)json
{
    
}

- (void)sendTypeChat:(NSString *)stage targetId:(NSInteger)targetId msgType:(NSInteger)msgType content:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:stage forKey:KEYQ_S_CHAT_CHAT_STAGE];
    [params setObject:[NSNumber numberWithInteger:targetId] forKey:KEYQ_S_CHAT_CHAT_TARGETID];
    [params setObject:[NSNumber numberWithInteger:msgType] forKey:KEYQ_S_CHAT_CHAT_MSGTYPE];
    [params setObject:content forKey:KEYQ_S_CHAT_CHAT_CONTENT];
    IMNWMessage *message = [IMNWMessage createForSocket:MARK_CHAT withType:TYPE_S_CHAT_CHAT];
    [message send:params];
}

- (void)parseTypeChat:(id)json;
{
    NSMutableDictionary *info = [json objectForKey:SOCKET_INFO];
    int res = [[info objectForKey:KEYP_S_CHAT_CHAT_RES] intValue];
    if (res == RES_OK) {
        NSLog(@"%@",json);
    }
    else {
        NSError *error = [self processErrorCode:res fromSource:[NSString stringWithFormat:@"%@_%@", MARK_CHAT, TYPE_S_CHAT_CHAT]];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_S_CHAT_CHAT object:error];
    }
}

- (void)parseTypeChatn:(id)json
{
    NSMutableDictionary *info = [json objectForKey:SOCKET_INFO];
    DPChatMessage *dpChatMessage = [[DPChatMessage alloc] init];
    dpChatMessage.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
    dpChatMessage.msgType = [[info objectForKey:KEYP_S_CHAT_CHATN_MSGTYPE] integerValue];
    dpChatMessage.content = [info objectForKey:KEYP_S_CHAT_CHATN_CONTENT];
    dpChatMessage.sendTime = [info objectForKey:KEYP_S_CHAT_CHATN_TIME];
    dpChatMessage.mid = [[info objectForKey:KEYP_S_CHAT_CHATN_MID] integerValue];
    dpChatMessage.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
    dpChatMessage.targetId = [[info objectForKey:KEYP_S_CHAT_CHATN_TARGETID] integerValue];
    dpChatMessage.stage = [info objectForKey:KEYP_S_CHAT_CHATN_STAGE];
    [[[ChatDataProxy sharedProxy] mutableArrayMessages] addObject:dpChatMessage];
    DPUiMessage *dpUiMessage = [[DPUiMessage alloc] init];
    dpUiMessage.orderid = [[MsgDataProxy sharedProxy] getUiMsgListNextOrderId];
    dpUiMessage.type = UI_MESSAGE_TYPE_CHAT;
    dpUiMessage.mid = dpChatMessage.mid;
    if (dpChatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid ) {
        dpUiMessage.relationId = dpChatMessage.targetId;
    }
    else {
        dpUiMessage.relationId = dpChatMessage.senderUid;
    }
    [[MsgDataProxy sharedProxy] updateUiMsgList:dpUiMessage];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_S_CHAT_CHATN object:dpChatMessage];
}

@end
