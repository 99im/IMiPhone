//
//  ChatMessageProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMessageProxy.h"

@implementation ChatMessageProxy

static ChatMessageProxy *messageProxy = nil;

+ (ChatMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageProxy = [[ChatMessageProxy alloc] init];
    });
    return messageProxy;
}

- (void)sendTypeP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum
{
    
}

- (void)parseTypeP2PChatList:(id)json
{
    
}

- (void)sendTypeP2PChat:(NSInteger)targetUid type:(NSInteger)msgType content:(NSString *)content
{
    //使用socket
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithInteger:targetUid] forKey:KEYQ_H__CHAT_P2PCHAT__TARGETUID];
    [params setObject:[NSNumber numberWithInteger:msgType] forKey:KEYQ_H__CHAT_P2PCHAT__MSGTYPE];
    [params setObject:content forKey:KEYQ_H__CHAT_P2PCHAT__CONTENT];
    
    IMNWMessage *message = [IMNWMessage createForSocket:MARK_CHAT withType:PATH_H__CHAT_P2PCHAT_];
    [message send:params];
}

- (void)parseTypeP2PChat:(id)json;
{
    NSLog(@"%@",json);
}

@end
