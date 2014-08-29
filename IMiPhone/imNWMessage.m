//
//  imNWMessage.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWMessage.h"
#import "UserMessageProxy.h"
#import "FriendMessageProxy.h"

@implementation imNWMessage

@synthesize connect;
@synthesize mark;
@synthesize type;
@synthesize host;
@synthesize path;

- (NSData *)getSocketData
{
    if ([self.data isKindOfClass:[NSData class]] == YES) {
        return self.data;
    }
    return nil;
}

- (NSMutableDictionary *)getHttpParams
{
    if ([self.data isKindOfClass:[NSMutableDictionary class]] == YES) {
        return self.data;
    }
    return nil;
}

- (NSDictionary *)getResponseJson
{
    if ([self.data isKindOfClass:[NSDictionary class]] == YES) {
        return self.data;
    }
    return nil;
}

- (void)excute
{
    if ([self.mark isEqualToString:MARK_LOGIN] == YES) {
        [[UserMessageProxy sharedMark] parseMessage:self];
    }
    else if ([self.mark isEqualToString:MARK_FRIEND] == YES) {
        [[FriendMessageProxy sharedMark] parseMessage:self];
    }
}

@end
