//
//  imNWMessage.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWMessage.h"
#import "imNWProxy.h"
#import "imNWManager.h"

@implementation imNWMessage

@synthesize connect;
@synthesize mark;
@synthesize type;
@synthesize host;
@synthesize path;

+ (imNWMessage *)createForSocket:(NSString *)mark withType:(NSString *)type
{
    imNWMessage *message = [[imNWMessage alloc] init];
    message.connect = CONNECT_SOCKET;
    message.mark = mark;
    message.type = type;
    return message;
}

+ (imNWMessage *)createForHttp:(NSString *)host onPath:(NSString *)path withParams:(NSMutableDictionary *)params
{
    imNWMessage *message = [[imNWMessage alloc] init];
    message.connect = CONNECT_HTTP;
    message.host = host;
    message.path = path;
    message.data = params;
    return message;
}

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
    NSString *markCapitalized = [self.mark capitalizedString];
    NSString *clz = [NSString stringWithFormat:@"%@MessageProxy", markCapitalized];
    Class clsProxy = NSClassFromString(clz);
    if (clsProxy) {
        imNWProxy *proxy = [clsProxy sharedProxy];
        [proxy parseMessage:self];
    }
    else {
        NSAssert1(YES, @"No such Class: %@", clz);
    }
}

- (void)send:(NSMutableDictionary *)info
{
    if (self.connect == CONNECT_SOCKET) {
        NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
        [json setObject:mark forKey:@"mark"];
        [json setObject:type forKey:@"type"];
        if (info) {
            [json setObject:info forKey:@"info"];
        }
        self.data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    }
    [[imNWManager sharedNWManager] sendMessage:self withResponse:nil];
}

@end
