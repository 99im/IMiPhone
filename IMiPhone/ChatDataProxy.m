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

@property (nonatomic, retain) NSDictionary *dicMessages;

@property (nonatomic, retain) NSDictionary *dicEmotion;

@property (nonatomic, retain) NSDictionary *dicGroupMessages;


@end

@implementation ChatDataProxy

@synthesize chatViewType;
@synthesize chatToUid;
@synthesize chatToGroupid;

@synthesize arrEmotions = _arrEmotions;

@synthesize dicEmotion = _dicEmotion;

static ChatDataProxy *messageDataProxy = nil;

+ (ChatDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDataProxy = [[self alloc] init];
    });
    return messageDataProxy;
}
#pragma mark - messages

- (NSMutableArray *)getP2PChatMessagesByTargetUid:(long long)targetUid
{
    if (self.dicMessages == nil) {
        self.dicMessages = [NSMutableDictionary dictionary];
    }
    NSMutableArray *arrMessagesWithHer = [self.dicMessages objectForKey:[NSNumber numberWithLongLong:targetUid]];
    if (arrMessagesWithHer == nil) {
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"stage=? AND senderUid=? OR targetId=?" Bind:[NSMutableArray arrayWithObjects:CHAT_STAGE_P2P,[NSString stringWithFormat:@"%lli",targetUid],[NSString stringWithFormat:@"%lli",targetUid],nil]];
        arrMessagesWithHer = [NSMutableArray array];
        DPChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [arrMessagesWithHer addObject:tempMessage];
            }
        }
        [self.dicMessages setValue:arrMessagesWithHer forKey:[NSString stringWithFormat:@"%lli",targetUid]];
    }
    return arrMessagesWithHer;
}

- (void)updateP2PChatMessage:(DPChatMessage *)dpChatMessage
{
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
    long long herUid;
    if (dpChatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        herUid = dpChatMessage.targetId;
    }
    else {
        herUid = dpChatMessage.senderUid;
    }
    NSMutableArray *arrMessagesWithHer = [self getP2PChatMessagesByTargetUid:herUid];

    NSInteger findIndex = [ImDataUtil getIndexOf:arrMessagesWithHer byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_MID withValue:[NSNumber numberWithLongLong:tempDBMessage.mid]];
    if (findIndex != NSNotFound) {
        [arrMessagesWithHer replaceObjectAtIndex:findIndex withObject:dpChatMessage];
        [[ChatMessageDAO sharedDAO] update:tempDBMessage ByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_MID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%lli",dpChatMessage.mid]]];
    }
    else
    {
        [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
        [arrMessagesWithHer addObject:dpChatMessage];
        NSLog(@"arrMessages insert message id:%ld", (long)((DPChatMessage *)dpChatMessage).senderUid);
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

- (NSMutableArray *)getGroupChatMessagesByGroupid:(long long)groupid
{
    if (self.dicGroupMessages == nil) {
        self.dicGroupMessages = [NSMutableDictionary dictionary];
    }
    NSMutableArray *arrGroupMessages = [self.dicGroupMessages objectForKey:[NSNumber numberWithLongLong:groupid]];
    if (arrGroupMessages == nil) {
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"stage=? AND targetId=?" Bind:[NSMutableArray arrayWithObjects:CHAT_STAGE_GROUP, [NSString stringWithFormat:@"%lli",groupid],nil]];
        arrGroupMessages = [NSMutableArray array];
        DPGroupChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPGroupChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [arrGroupMessages addObject:tempMessage];
            }
        }
        [self.dicGroupMessages setValue:arrGroupMessages forKey:[NSString stringWithFormat:@"%lli",groupid]];
    }
    return arrGroupMessages;
}

- (void)updateGroupChatMessage:(DPGroupChatMessage *)dpChatMessage
{
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
    long long groupid = dpChatMessage.targetId;
    NSMutableArray *arrMessagesWithHer = [self getP2PChatMessagesByTargetUid:groupid];
    
    NSInteger findIndex = [ImDataUtil getIndexOf:arrMessagesWithHer byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_MID withValue:[NSNumber numberWithLongLong:tempDBMessage.mid]];
    if (findIndex != NSNotFound) {
        [arrMessagesWithHer replaceObjectAtIndex:findIndex withObject:dpChatMessage];
        [[ChatMessageDAO sharedDAO] update:tempDBMessage ByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_MID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%lli",dpChatMessage.mid]]];
    }
    else
    {
        [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
        [arrMessagesWithHer addObject:dpChatMessage];
        NSLog(@"arrGroupMessages insert message id:%lli", (long long)((DPChatMessage *)dpChatMessage).senderUid);
    }
}

- (DPChatMessage *)getGroupChatMessageByGroupid:(long long)targetUid withMid:(long long)mid
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
@end
