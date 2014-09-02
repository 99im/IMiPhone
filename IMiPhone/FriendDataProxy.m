//
//  FriendDataProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDataProxy.h"

@implementation FriendDataProxy

@synthesize arrGroups;

static FriendDataProxy *sharedFriendDataProxy = nil;

+ (FriendDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFriendDataProxy = [[self alloc] init];
    });
    return sharedFriendDataProxy;
}

@end
