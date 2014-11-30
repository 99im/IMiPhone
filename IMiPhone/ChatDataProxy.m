//
//  MessageDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatDataProxy.h"
#import "UserDataProxy.h"
#import "ChatMessageProxy.h"
#import "ImDataUtil.h"

@interface ChatDataProxy()

@property (nonatomic, retain) NSMutableDictionary *dicMessages;

@property (nonatomic, retain, getter=getDicMessages) NSMutableDictionary *dicEmotion;

@property (nonatomic,getter=getMaxNid) NSInteger maxNid;

@end

@implementation ChatDataProxy

@synthesize chatViewType;
@synthesize chatToUid;
@synthesize chatToGroupid;

@synthesize arrEmotions = _arrEmotions;

@synthesize dicEmotion = _dicEmotion;

@synthesize dicMessages = _dicMessages;

@synthesize maxNid = _maxNid;

static ChatDataProxy *messageDataProxy = nil;

+ (ChatDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDataProxy = [[self alloc] init];
    });
    return messageDataProxy;
}

- (id)init
{
    if (self = [super init]) {
        _maxNid = NSIntegerMax;
    }
    return self;
}

- (void)reset
{
    self.dicMessages = nil;
    _maxNid = NSIntegerMax;
}

- (NSMutableDictionary *)getDicMessages
{
    if (_dicMessages == nil) {
        _dicMessages = [NSMutableDictionary dictionary];
    }
    return _dicMessages;
}

#pragma mark - messages

- (NSMutableArray *)getP2PChatMessagesByGid:(NSString *)gid
{
    if (self.dicMessages == nil) {
        self.dicMessages = [NSMutableDictionary dictionary];
    }
    NSMutableArray *arrMessagesWithHer = [self.dicMessages objectForKey:gid];
    if (arrMessagesWithHer == nil) {
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"stage=? AND gid=?" Bind:[NSMutableArray arrayWithObjects:CHAT_STAGE_P2P,gid,nil]];
        arrMessagesWithHer = [NSMutableArray array];
        DPChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [arrMessagesWithHer addObject:tempMessage];
            }
        }
        [self.dicMessages setValue:arrMessagesWithHer forKey:gid];
    }
    return arrMessagesWithHer;
}

- (NSMutableArray *)getP2PChatMessagesByTargetUid:(long long)targetUid
{
    NSString *gid = [self assembleGidWithStage:CHAT_STAGE_P2P withSenderUid:[UserDataProxy sharedProxy].lastLoginUid withTargetId:targetUid];
    
    return [self getP2PChatMessagesByGid:gid];
}

- (NSInteger)addP2PChatMessage:(DPChatMessage *)dpChatMessage
{
    NSString *gid = dpChatMessage.gid;
    NSMutableArray *arrMessagesWithHer = [self getP2PChatMessagesByGid:gid];
    if (arrMessagesWithHer.count == 0)
        dpChatMessage.nid = 0;
    else
        dpChatMessage.nid = ((DPChatMessage *)arrMessagesWithHer.lastObject).nid + 1;
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
    tempDBMessage.nid = dpChatMessage.nid;
    [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
    [arrMessagesWithHer addObject:dpChatMessage];
    NSLog(@"arrMessages insert message id:%lli", ((DPChatMessage *)dpChatMessage).mid);
    return dpChatMessage.nid;
}

- (void)updateP2PChatMessage:(DPChatMessage *)dpChatMessage
{
    NSString *gid = dpChatMessage.gid;
    NSMutableArray *arrMessagesWithHer = [self getP2PChatMessagesByGid:gid];
    NSInteger findIndex = [ImDataUtil getIndexOf:arrMessagesWithHer byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_NID withValue:[NSNumber numberWithLongLong:dpChatMessage.nid]];
    if (findIndex != NSNotFound) {
        DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
        [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
        [arrMessagesWithHer replaceObjectAtIndex:findIndex withObject:dpChatMessage];
        [[ChatMessageDAO sharedDAO] update:tempDBMessage ByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_NID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%li", (long)dpChatMessage.nid]]];
    }
    else
    {
        [self addP2PChatMessage:dpChatMessage];
    }
}

- (DPChatMessage *)getP2PChatMessageByTargetUid:(long long)targetUid withMid:(long long)mid;
{
    NSArray *chatMessages = [self getP2PChatMessagesByTargetUid:targetUid];
    NSInteger findindex = [chatMessages indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && ((DPChatMessage *)obj).mid == mid) {
            return YES;
        }
        return NO;
    }];
    if (findindex != NSNotFound) {
        return [chatMessages objectAtIndex:findindex];
    }
    return nil;
}

#pragma mark - group messages

- (NSMutableArray *)getGroupChatMessagesByGid:(NSString *)gid
{
    
    NSMutableArray *arrGroupMessages = [self.dicMessages objectForKey:gid];
    if (arrGroupMessages == nil) {
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"stage=? AND gid=?" Bind:[NSMutableArray arrayWithObjects:CHAT_STAGE_GROUP, gid,nil]];
        arrGroupMessages = [NSMutableArray array];
        DPGroupChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPGroupChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [arrGroupMessages addObject:tempMessage];
            }
        }
        [self.dicMessages setValue:arrGroupMessages forKey:gid];
    }
    return arrGroupMessages;
}

- (NSMutableArray *)getGroupChatMessagesByGroupid:(long long)groupid
{
    NSString *gid = [self assembleGidWithStage:CHAT_STAGE_GROUP withSenderUid:0 withTargetId:groupid];
    return [self getGroupChatMessagesByGid:gid];
}

- (NSInteger)addGroupChatMessage:(DPGroupChatMessage *)dpChatMessage
{
    NSString *gid = dpChatMessage.gid;
    NSMutableArray *arrMessagesInGroup = [self getGroupChatMessagesByGid:gid];
    if (arrMessagesInGroup.count == 0)
        dpChatMessage.nid = 0;
    else
        dpChatMessage.nid = ((DPChatMessage *)arrMessagesInGroup.lastObject).nid + 1;
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
    [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
    [arrMessagesInGroup addObject:dpChatMessage];
    NSLog(@"arrGroupMessages insert message id:%li", (long)((DPChatMessage *)dpChatMessage).nid);
    return dpChatMessage.nid;
}

- (void)updateGroupChatMessage:(DPGroupChatMessage *)dpChatMessage
{
    NSString *gid = dpChatMessage.gid;
    NSMutableArray *arrMessagesInGroup = [self getGroupChatMessagesByGid:gid];
    NSInteger findIndex = [ImDataUtil getIndexOf:arrMessagesInGroup byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_NID withValue:[NSNumber numberWithLongLong:dpChatMessage.nid]];
    if (findIndex != NSNotFound) {
        DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
        [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
        [arrMessagesInGroup replaceObjectAtIndex:findIndex withObject:dpChatMessage];
        [[ChatMessageDAO sharedDAO] update:tempDBMessage ByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_NID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%li", (long)dpChatMessage.nid]]];
    }
    else
    {
        [self addP2PChatMessage:dpChatMessage];
    }
}

- (DPGroupChatMessage *)getGroupChatMessageByGroupid:(long long)targetUid withMid:(long long)mid
{
    NSArray *groupChatMessages = [self getGroupChatMessagesByGroupid:targetUid];
    NSInteger findindex = [ImDataUtil getIndexOf:groupChatMessages byItemKey:@"mid" withValue:[NSNumber numberWithLongLong:mid]];
    
    if (findindex != NSNotFound) {
        return [groupChatMessages objectAtIndex:findindex];
    }
    
    return nil;
}

#pragma mark - others


- (NSArray *)getEmotions
{
    if (_arrEmotions == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"emotion" ofType:@"plist"];
        _arrEmotions = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    return _arrEmotions;
}

- (NSDictionary *)getEmotionDic
{
    if (_dicEmotion == nil) {
        _dicEmotion = [NSMutableDictionary dictionary];
        NSArray *arrEmots = [self getEmotions];
        for (NSInteger i = 0; i < [arrEmots count]; i++) {
            NSDictionary *dicEmot = [arrEmots objectAtIndex:i];
            NSString *emotid = [dicEmot objectForKey:@"id"];
//            [emotid st]
            NSString *emotImage = [dicEmot objectForKey:@"image"];
            [_dicEmotion setValue:emotImage forKey:emotid];
        }
    }
    return _dicEmotion;
}

//根据会话类型stage,和发送者id,和目标id targetid 组装会话唯一id gid
- (NSString *)assembleGidWithStage:(NSString *)stage withSenderUid:(long long)sid withTargetId:(long long)targetId
{
    NSString *strResult;
    if ([stage isEqualToString:CHAT_STAGE_P2P]) {
        long long smallUid;
        long long bigUid;
        if (sid > targetId) {
            smallUid = targetId;
            bigUid = sid;
        }
        else {
            smallUid = sid;
            bigUid = targetId;
        }
        strResult = [NSString stringWithFormat:@"p_%lli_%lli",smallUid,bigUid];
    }
    else  if ([stage isEqualToString:CHAT_STAGE_GROUP]) {
        strResult = [NSString stringWithFormat:@"g_%lli", targetId];
    }
    return strResult;
}


- (void)updateUnreadWithGid:(NSString *)gid withTotal:(NSInteger)total withUnreadList:(NSArray *)list
{
    //TODO:修改uiMessage 中unread 和 releationId
//    [[MsgDataProxy sharedProxy] ]
    
    //数据库中插入未获得内容的空消息
    DBChatMessage *dbModel;
    NSInteger i = 0;
    for ( ; i < total - list.count; i++) {
        dbModel = [[DBChatMessage alloc] init];
        dbModel.gid = gid;
        dbModel.nid = self.maxNid + 1;
        [self increaseMaxNid];
        [[ChatMessageDAO sharedDAO] insert:dbModel];
    }
    //数据库中插入返回的最近数据
    NSDictionary *info;
    for (NSInteger j = 0; j < list.count; j++) {
        info = [list objectAtIndex:j];
        dbModel = [[DBChatMessage alloc] init];
        dbModel.nid = self.maxNid + 1;
        [self increaseMaxNid];
        dbModel.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dbModel.msgType = [[info objectForKey:KEYP_S_CHAT_CHATN_MSGTYPE] integerValue];
        dbModel.content = [info objectForKey:KEYP_S_CHAT_CHATN_CONTENT];
        dbModel.sendTime = [info objectForKey:KEYP_S_CHAT_CHATN_TIME];
        dbModel.mid = [[info objectForKey:KEYP_S_CHAT_CHATN_MID] integerValue];
        dbModel.senderUid = [[info objectForKey:KEYP_S_CHAT_CHATN_SENDUID] integerValue];
        dbModel.targetId = [[info objectForKey:KEYP_S_CHAT_CHATN_TARGETID] integerValue];
        dbModel.stage = [info objectForKey:KEYP_S_CHAT_CHATN_STAGE];
        dbModel.gid = [info objectForKey:KEYP_S_CHAT_CHATN_GID];
        [[ChatMessageDAO sharedDAO] insert:dbModel];
    }
}

//返回最大nid
- (NSInteger)getMaxNid
{
//    if (_maxNid == NSIntegerMax) {
        _maxNid = [[ChatMessageDAO sharedDAO] primaryKeyMaxValue];
//    }
    return _maxNid;
}
- (void)increaseMaxNid
{
    if (_maxNid == NSIntegerMax) {
        NSLog(@"increaseMaxNid _maxNid == NSIntegerMax!!!");
    }
    else {
        _maxNid ++;
    }
}

@end
