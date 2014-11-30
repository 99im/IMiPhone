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
#import "DPGroupChatMessage.h"

typedef enum {
    ChatViewTypeP2P = 0,
    ChatViewTypeP2G
}ChatViewType;

@interface ChatDataProxy : NSObject

@property (nonatomic) NSInteger chatViewType;
@property (nonatomic) long long chatToUid;
@property (nonatomic) long long chatToGroupid;

@property (nonatomic, retain, getter=getEmotions) NSArray *arrEmotions;

+ (ChatDataProxy*)sharedProxy;

- (void)reset;

- (NSMutableArray *)getP2PChatMessagesByTargetUid:(long long)targetUid;
- (NSInteger)addP2PChatMessage:(DPChatMessage *)dpChatMessage;
- (void)updateP2PChatMessage:(DPChatMessage *)dpChatMessage;

- (DPChatMessage *)getP2PChatMessageByTargetUid:(long long)targetUid withMid:(long long)mid;

- (NSArray *)getEmotions;

- (NSDictionary *)getEmotionDic;

- (NSMutableArray *)getGroupChatMessagesByGroupid:(long long)groupid;
- (NSInteger)addGroupChatMessage:(DPGroupChatMessage *)dpChatMessage;
- (void)updateGroupChatMessage:(DPGroupChatMessage *)dpChatMessage;

- (DPGroupChatMessage *)getGroupChatMessageByGroupid:(long long)targetUid withMid:(long long)mid;

- (NSString *)assembleGidWithStage:(NSString *)stage withSenderUid:(long long)sid withTargetId:(long long)targetId;

//gid:会话id; total:总未读消息数; list:离现在最近的未读消息列表(最多20条)
- (void)updateUnreadWithGid:(NSString *)gid withTotal:(NSInteger)total withUnreadList:(NSArray *)list;

- (NSInteger)getMaxNid;

@end
