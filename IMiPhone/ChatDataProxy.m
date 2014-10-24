//
//  MessageDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatDataProxy.h"

@interface ChatDataProxy()

@property (nonatomic, retain) NSMutableArray *arrMessages;
@property (nonatomic, retain) NSMutableArray *arrMessageGroups;

@end

@implementation ChatDataProxy

@synthesize arrMessageGroups = _arrMessageGroups;
@synthesize arrMessages = _arrMessages;

static ChatDataProxy *messageDataProxy = nil;

+ (ChatDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDataProxy = [[ChatDataProxy alloc] init];
    });
    return messageDataProxy;
}
#pragma mark - messages

- (NSMutableArray *)mutableArrayMessages
{
    if (_arrMessages == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBMessages = [[ChatMessageDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrMessages = [NSMutableArray array];
        DPChatMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPChatMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
                [_arrMessages addObject:tempMessage];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrMessages"];
}

- (void)insertObject:(id)object inArrMessagesAtIndex:(NSUInteger)index
{
    
    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
    [ImDataUtil copyFrom:object To:tempDBMessage];
    
    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrMessages byItemKey:DB_PRIMARY_KEY_CHAT_MESSAGE_MID withValue:[NSNumber numberWithInteger:tempDBMessage.mid]];
    if (findIndex != NSNotFound) {
        [[self mutableArrayMessages] replaceObjectAtIndex:findIndex withObject:object];
    }
    else
    {
        
        [[ChatMessageDAO sharedDAO] insert: tempDBMessage];
        [self.arrMessages insertObject:object atIndex:index];
        NSLog(@"arrMessages insert message id:%ld", (long)((DPChatMessage *)object).senderUid);
    }
}

-(void)removeObjectFromArrMessagesAtIndex:(NSUInteger)index

{
    DPChatMessage *dpMessage = self.arrMessages[index];
    [[ChatMessageDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_CHAT_MESSAGE_MID stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%li",(long)dpMessage.mid],nil]];
    [self.arrMessages removeObjectAtIndex:index];
    NSLog(@"remove arrMessages at index :%li",(unsigned long)index);
   
}

//- (void)replaceObjectInArrMessagesAtIndex:(NSUInteger)index withObject:(id)object
//{
//    DBChatMessage *tempDBMessage = [[DBChatMessage alloc] init];
//    [ImDataUtil copyFrom:object To:tempDBMessage];
//
//    [[ChatMessageDAO sharedDAO] update:
//     tempDBMessage
//                       ByCondition:[DB_PRIMARY_KEY_SENDER_ID stringByAppendingString:@"=?"]
//                              Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%li",(long)tempDBMessage.senderUid],nil]];
//    [self.arrMessages replaceObjectAtIndex:index withObject:object];
//    NSLog(@"replace arrMessages at %li,with new sender id:%li",index,(long)((DPChatMessage *)object).senderUid);
//}

#pragma mark - messageGroups

- (NSMutableArray *)mutableArrayMessageGroups
{
    if (_arrMessageGroups == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBMessageGroups = [[MessageGroupDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrMessageGroups = [NSMutableArray array];
        DPMessageGroup *tempMessageGroup;
        if (arrDBMessageGroups) {
            for (NSInteger i = 0; i < arrDBMessageGroups.count; i++) {
                tempMessageGroup = [[DPMessageGroup alloc] init];
                [ImDataUtil copyFrom:arrDBMessageGroups[i] To:tempMessageGroup];
                 [_arrMessageGroups addObject:tempMessageGroup];
            }
        }
    }
    return _arrMessages;
}

- (void)insertObject:(id)object inArrMessageGroupAtIndex:(NSUInteger)index
{
    [self.arrMessageGroups insertObject:object atIndex:index];
    NSLog(@"arrMessageGroups insert messageGroupId:%@",((DPMessageGroup *)object).messageGroupId);
}

-(void)removeObjectFromArrMessageGroupsAtIndex:(NSUInteger)index
{
    [self.arrMessageGroups removeObjectAtIndex:index];
    NSLog(@"arrMessageGroups remove at%li",(unsigned long)index);
    
}

//-(void)replaceObjectInArrMessageGroupsAtIndex:(NSUInteger)index withObject:(id)object
//{
//    [self.arrMessageGroups replaceObjectAtIndex:index withObject:object];
//    NSLog(@"arrMessageGroups replace at %li,messageGroupId:%@",(unsigned long)index,((DPMessageGroup *)object).messageGroupId);
//    
//}

@end
