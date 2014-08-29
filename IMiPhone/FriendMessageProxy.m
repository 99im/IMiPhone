//
//  MarkFriend.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendMessageProxy.h"

#define TYPE_GROUPS @"groups"

@implementation FriendMessageProxy

static FriendMessageProxy *sharedMark = nil;

+ (FriendMessageProxy *)sharedMark
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMark = [[self alloc] init];
    });
    return sharedMark;
}

- (void)parseMessage:(imNWMessage *)message
{
    if ([message.type isEqualToString:TYPE_GROUPS] == YES) {
        [self parseTypeGroups:[message getResponseJson]];
    }
}

- (void)sendTypeGroups
{
    
}

- (void)parseTypeGroups:(id)json
{
    
}

@end
