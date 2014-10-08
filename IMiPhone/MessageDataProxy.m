//
//  MessageDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MessageDataProxy.h"

@interface MessageDataProxy()

@property (nonatomic, retain) NSMutableArray *arrMessages;
@property (nonatomic, retain) NSMutableArray *arrMessageGroups;

@end

@implementation MessageDataProxy

@synthesize arrMessageGroups = _arrMessageGroups;
@synthesize arrMessages = _arrMessages;

static MessageDataProxy *messageDataProxy = nil;

+ (MessageDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDataProxy = [[MessageDataProxy alloc] init];
    });
    return messageDataProxy;
}
#pragma mark - messages

- (NSMutableArray *)mutableArrayMessages
{
    if (_arrMessages == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBMessages = [[MessageDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrMessages = [NSMutableArray array];
        DPMessage *tempMessage;
        if (arrDBMessages) {
            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
                tempMessage = [[DPMessage alloc] init];
                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrMessages"];
}

- (void)insertObject:(id)object inArrMessagesAtIndex:(NSUInteger)index
{
    DBMessage *tempDBMessage = [[DBMessage alloc] init];
    [ImDataUtil copyFrom:object To:tempDBMessage];
    [[MessageDAO sharedDAO] insert:tempDBMessage];
    [self.arrMessages insertObject:object atIndex:index];
    NSLog(@"arrMessages insert message id:%ld", (long)((DPMessage *)object).senderUid);
}

-(void)removeObjectFromArrMessagesAtIndex:(NSUInteger)index

{
    DPMessage *dpMessage = self.arrMessages[index];
    [[MessageDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_SENDER_ID stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",dpMessage.senderUid],nil]];
    [self.arrMessages removeObjectAtIndex:index];
    NSLog(@"remove arrMessages at index :%d",index);
   
}

- (void)replaceObjectInArrMessagesAtIndex:(NSUInteger)index withObject:(id)object
{
    DBMessage *tempDBMessage = [[DBMessage alloc] init];
    [ImDataUtil copyFrom:object To:tempDBMessage];

    [[MessageDAO sharedDAO] update:
     tempDBMessage
                       ByCondition:[DB_PRIMARY_KEY_SENDER_ID stringByAppendingString:@"=?"]
                              Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",tempDBMessage.senderUid],nil]];
    [self.arrMessages replaceObjectAtIndex:index withObject:object];
    NSLog(@"replace arrMessages at %d,with new sender id:%@",index,((DPMessage *)object).senderUid);
}

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
    NSLog(@"arrMessageGroups remove at%d",index);
    
}

-(void)replaceObjectInArrMessageGroupsAtIndex:(NSUInteger)index withObject:(id)object
{
    [self.arrMessageGroups replaceObjectAtIndex:index withObject:object];
    NSLog(@"arrMessageGroups replace at %d,messageGroupId:%@",index,((DPMessageGroup *)object).messageGroupId);
    
}

@end
