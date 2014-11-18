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

- (void)sendHttpUploadimg:(id)image
{
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__CHAT_UPLOADIMG_ withParams:nil withMethod:METHOD_H__CHAT_UPLOADIMG_ ssl:NO];
    NSMutableDictionary *multiPartData = [NSMutableDictionary dictionary];
    [multiPartData setObject:image forKey:KEYQ_H__CHAT_UPLOADIMG__UPLOADIMG];
    message.multiPartData = multiPartData;
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__CHAT_UPLOADIMG__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSDictionary *dicImgInfo = [json objectForKey:KEYP_H__CHAT_UPLOADIMG__IMGINFO];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__CHAT_UPLOADIMG_ object:nil userInfo:dicImgInfo];
            }
            else {
                [self processErrorCode:errorcode fromSource:PATH_H__CHAT_UPLOADIMG_ useNotiName:NOTI_H__CHAT_UPLOADIMG_];
            }
        }
    }];
}

- (void)sendTypeP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum
{
    
}

- (void)parseTypeP2PChatList:(id)json
{
    
}

- (void)sendTypeChat:(NSString *)stage targetId:(long long)targetId msgType:(NSInteger)msgType content:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:stage forKey:KEYQ_S_CHAT_CHAT_STAGE];
    [params setObject:[NSNumber numberWithLongLong:targetId] forKey:KEYQ_S_CHAT_CHAT_TARGETID];
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
        [self processErrorCode:res fromSource:[NSString stringWithFormat:@"%@_%@", MARK_CHAT, TYPE_S_CHAT_CHAT] useNotiName:NOTI_S_CHAT_CHAT];
    }
}

- (void)parseTypeChatn:(id)json
{
    NSMutableDictionary *info = [json objectForKey:SOCKET_INFO];
    NSString *stage = [info objectForKey:KEYP_S_CHAT_CHATN_STAGE];
    DPUiMessage *dpUiMessage = [[DPUiMessage alloc] init];
    dpUiMessage.orderid = [[MsgDataProxy sharedProxy] getUiMsgListNextOrderId];
    if ([stage isEqualToString:CHAT_STAGE_P2P]) {
        
        DPChatMessage *dpChatMessage = [[DPChatMessage alloc] init];
        dpChatMessage.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dpChatMessage.msgType = [[info objectForKey:KEYP_S_CHAT_CHATN_MSGTYPE] integerValue];
        dpChatMessage.content = [info objectForKey:KEYP_S_CHAT_CHATN_CONTENT];
        dpChatMessage.sendTime = [info objectForKey:KEYP_S_CHAT_CHATN_TIME];
        dpChatMessage.mid = [[info objectForKey:KEYP_S_CHAT_CHATN_MID] integerValue];
        dpChatMessage.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dpChatMessage.targetId = [[info objectForKey:KEYP_S_CHAT_CHATN_TARGETID] integerValue];
        dpChatMessage.stage = [info objectForKey:KEYP_S_CHAT_CHATN_STAGE];
        dpChatMessage.gid = [info objectForKey:KEYP_S_CHAT_CHATN_GID];
        [[ChatDataProxy sharedProxy] updateP2PChatMessage:dpChatMessage];
      
        dpUiMessage.type = UI_MESSAGE_TYPE_CHAT;
        dpUiMessage.mid = dpChatMessage.mid;
        if (dpChatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid ) {
            dpUiMessage.relationId = dpChatMessage.targetId;
        }
        else {
            dpUiMessage.relationId = dpChatMessage.senderUid;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_S_CHAT_CHATN object:dpChatMessage];
    }
    else if ([stage isEqualToString:CHAT_STAGE_GROUP]) {
       
        DPGroupChatMessage *dpGroupChatMsg = [[DPGroupChatMessage alloc] init];
        dpGroupChatMsg.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dpGroupChatMsg.msgType = [[info objectForKey:KEYP_S_CHAT_CHATN_MSGTYPE] integerValue];
        dpGroupChatMsg.content = [info objectForKey:KEYP_S_CHAT_CHATN_CONTENT];
        dpGroupChatMsg.sendTime = [info objectForKey:KEYP_S_CHAT_CHATN_TIME];
        dpGroupChatMsg.mid = [[info objectForKey:KEYP_S_CHAT_CHATN_MID] integerValue];
        dpGroupChatMsg.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dpGroupChatMsg.targetId = [[info objectForKey:KEYP_S_CHAT_CHATN_TARGETID] integerValue];
        dpGroupChatMsg.stage = [info objectForKey:KEYP_S_CHAT_CHATN_STAGE];
        dpGroupChatMsg.gid = [info objectForKey:KEYP_S_CHAT_CHATN_GID];
        [[ChatDataProxy sharedProxy] updateGroupChatMessage:dpGroupChatMsg];
        dpUiMessage.type = UI_MESSAGE_TYPE_GROUP_CHAT;
        dpUiMessage.mid = dpGroupChatMsg.mid;
        dpUiMessage.relationId = dpGroupChatMsg.targetId ;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_S_CHAT_CHATN object:dpGroupChatMsg];
    }
    else
    {
        NSLog(@"parseTypeChatn error stage:%@",stage);
    }
   
   
    if (dpUiMessage) {
        [[MsgDataProxy sharedProxy] updateUiMsgList:dpUiMessage];
    }
   
}

@end
