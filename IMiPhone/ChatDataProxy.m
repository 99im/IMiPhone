//
//  ChatDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatDataProxy.h"

@implementation ChatDataProxy

static ChatDataProxy *chatDataProxy = nil;

+ (ChatDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatDataProxy = [[ChatDataProxy alloc] init];
    });
    return chatDataProxy;
}

@end
