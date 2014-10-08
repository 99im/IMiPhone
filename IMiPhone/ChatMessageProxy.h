//
//  ChatMessageProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"
#import "imNWManager.h"
#import "NSNumber+IMNWError.h"

#define CHAT_MASSAGE_TYPE_TEXT 0
#define CHAT_MASSAGE_TYPE_AUDIO 1

@interface ChatMessageProxy : NSObject

+ (ChatMessageProxy *)sharedProxy;

- (void)sendTypeP2PChatList:(NSInteger)targetUid before:(NSInteger)beforeMid after:(NSInteger)afterMid startAt:(NSInteger)startIndex getNum:(NSInteger)pageNum;
- (void)parseTypeP2PChatList:(id)json;

- (void)sendTypeP2PChat:(NSInteger)targetUid type:(NSInteger)msgType content:(NSString *)content;
- (void)parseTypeP2PChat:(id)json;

@end
