//
//  MessageDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMessageDAO.h"
#import "UiMessageDAO.h"
#import "DPChatMessage.h"
#import "ImDataUtil.h"

typedef enum {
    ChatViewTypeP2P = 0,
    ChatViewTypeP2G
}ChatViewType;

@interface ChatDataProxy : NSObject

@property (nonatomic) NSInteger chatViewType;
@property (nonatomic) long long chatToUid;

@property (nonatomic, retain, getter=getEmotions) NSArray *arrEmotions;

+ (ChatDataProxy*)sharedProxy;

- (NSMutableArray *)getP2PChatMessagesByTargetUid:(long long)targetUid;
- (void)updateP2PChatMessage:(DPChatMessage *)dpChatMessage;

- (DPChatMessage *)getP2PChatMessageByTargetUid:(long long)targetUid withMid:(long long)mid;

- (NSArray *)getEmotions;

- (NSDictionary *)getEmotionDic;

@end
