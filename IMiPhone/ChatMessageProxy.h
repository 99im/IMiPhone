//
//  ChatMessageProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "NSNumber+IMNWError.h"
#import "IMNWProxy.h"
//#import "DPChatMessage.h"
#import "ChatDataProxy.h"
#import "MsgDataProxy.h"

#define CHAT_STAGE_P2P @"p2p"
#define CHAT_STAGE_GROUP @"group"

#define CHAT_MESSAGE_NID @"nid"

#define CHAT_MASSAGE_TYPE_TEXT 0
#define CHAT_MASSAGE_TYPE_IMAGE 1

@interface ChatMessageProxy : IMNWProxy

+ (ChatMessageProxy *)sharedProxy;

- (void)sendHttpUploadimg:(id)image withMessageNid:(NSInteger)nid;

- (void)sendHttpP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum;
- (void)parseTypeP2PChatList:(id)json;

- (void)sendTypeChat:(NSString *)stage targetId:(long long)targetId msgType:(NSInteger)msgType content:(NSString *)content nid:(NSInteger)nid;
- (void)parseTypeChat:(id)json;

- (void)parseTypeChatn:(id)json;

//readInfo string post 已读消息json串  {"p_16_17":66,"g_8":71} key为场景id 具体如下：如果是好友聊天则为p_uid1_uid2 uid1，uid2为自己uid和好友id，升序排律 如果是群聊天则为g_groupId
- (void)sendHttpUnReadListWithReadInfo:(NSDictionary *)readInfo;

@end
