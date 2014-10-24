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

#define CHAT_STAGE_P2P @"p2p"
#define CHAT_STAGE_GROUP @"group"

#define CHAT_MASSAGE_TYPE_TEXT 0
#define CHAT_MASSAGE_TYPE_AUDIO 1

@interface ChatMessageProxy : IMNWProxy

+ (ChatMessageProxy *)sharedProxy;

- (void)sendTypeP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum;
- (void)parseTypeP2PChatList:(id)json;

- (void)sendTypeChat:(NSString *)stage targetId:(NSInteger)targetId msgType:(NSInteger)msgType content:(NSString *)content;
- (void)parseTypeChat:(id)json;

- (void)parseTypeChatn:(id)json;

@end
