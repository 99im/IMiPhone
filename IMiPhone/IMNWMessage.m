//
//  imNWMessage.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWMessage.h"
#import "IMNWProxy.h"
#import "IMNWManager.h"
#import "UserDataProxy.h"

@implementation IMNWMessage

@synthesize connect;
@synthesize mark;
@synthesize type;
@synthesize host;
@synthesize port;
@synthesize path;
@synthesize useSSL;
@synthesize method;

+ (IMNWMessage *)createForSocket:(NSString *)mark withType:(NSString *)type
{
    IMNWMessage *message = [[IMNWMessage alloc] init];
    message.connect = CONNECT_SOCKET;
    message.mark = mark;
    message.type = type;
    return message;
}

+ (IMNWMessage *)createForHttp:(NSString *)path withParams:(NSMutableDictionary *)params withMethod:(NSString *)method ssl:(BOOL)useSSL
{
    IMNWMessage *message = [[IMNWMessage alloc] init];
    message.connect = CONNECT_HTTP;
    message.path = path;
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    if ([UserDataProxy sharedProxy].verify) {
        [params setObject:[UserDataProxy sharedProxy].verify forKey:HTTP_KEY_VERIFY];
    }
    message.data = params;
    message.method = method;
    message.useSSL = useSSL;
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
        IMNWProxy *proxy = [clsProxy sharedProxy];
        [proxy parseMessage:self];
    }
    else {
        NSAssert(YES, @"No such Class: %@", clz);
    }
}

- (void)send:(NSMutableDictionary *)info
{
    if (self.connect == CONNECT_SOCKET) {
        NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
        [json setObject:mark forKey:SOCKET_MARK];
        [json setObject:type forKey:SOCKET_TYPE];
        if (info) {
            [json setObject:info forKey:SOCKET_INFO];
        }
        self.data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    }
    [[IMNWManager sharedNWManager] sendMessage:self withResponse:nil];
}

- (void)useHost:(NSString *)phost andPort:(int)nport
{
    //底层暂不支持多http路径，需要扩展，使用dictionary持有不同host和port的http connect
    self.host = phost;
    self.port = nport;
}

@end
