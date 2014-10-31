//
//  MessageDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatDataProxy.h"
#import "UserDataProxy.h"

@interface ChatDataProxy()

@property (nonatomic, retain) NSDictionary *dicMessages;

@property (nonatomic, retain) NSDictionary *dicEmotion;

@end

@implementation ChatDataProxy

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

- (NSMutableArray *)getP2PChatMessagesByTargetUid:(long)targetUid
{
    if (self.dicMessages == nil) {
        self.dicMessages = [NSMutableDictionary dictionary];
    }
    NSMutableArray *arrMessagesWithHer = [self.dicMessages objectForKey:[NSNumber numberWithLong:targetUid]];
    if (arrMessagesWithHer == nil) {
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"senderUid=? OR targetId=?" Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld",targetUid],[NSString stringWithFormat:@"%ld",targetUid],nil]];
        arrMessagesWithHer = [NSMutableArray array];
        DPChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [arrMessagesWithHer addObject:tempMessage];
            }
        }
        [self.dicMessages setValue:arrMessagesWithHer forKey:[NSString stringWithFormat:@"%ld",targetUid]];
    }
    return arrMessagesWithHer;
}

- (void)updateP2PChatMessage:(DPChatMessage *)dpChatMessage
{
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:dpChatMessage To:tempDBMessage];
    long herUid;
    if (dpChatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        herUid = dpChatMessage.targetId;
    }
    else {
        herUid = dpChatMessage.senderUid;
    }
    NSMutableArray *arrMessagesWithHer = [self getP2PChatMessagesByTargetUid:herUid];

    NSInteger findIndex = [ImDataUtil getIndexOf:arrMessagesWithHer byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_MID withValue:[NSNumber numberWithInteger:tempDBMessage.mid]];
    if (findIndex != NSNotFound) {
        [arrMessagesWithHer replaceObjectAtIndex:findIndex withObject:dpChatMessage];
        [[ChatMessageDAO sharedDAO] update:tempDBMessage ByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_MID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%ld",dpChatMessage.mid]]];
    }
    else
    {
        [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
        [arrMessagesWithHer addObject:dpChatMessage];
        NSLog(@"arrMessages insert message id:%ld", (long)((DPChatMessage *)dpChatMessage).senderUid);
    }
}

- (DPChatMessage *)getP2PChatMessageByTargetUid:(long)targetUid withMid:(long)mid;
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
