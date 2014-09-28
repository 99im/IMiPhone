//
//  MessageDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MessageDataProxy.h"

@implementation MessageDataProxy

static MessageDataProxy *messageDataProxy = nil;

+ (MessageDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDataProxy = [[MessageDataProxy alloc] init];
    });
    return messageDataProxy;
}

- (void)insertObject:(id)object inArrMessagesAtIndex:(NSUInteger)index

{
//    [self.arrTest insertObject:object atIndex:index];
//    NSLog(@"insertObject%@",object);
}

@end
