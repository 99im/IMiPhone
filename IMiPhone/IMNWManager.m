//
//  imNWManager.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWManager.h"

@implementation IMNWManager

@synthesize socketConnect;
@synthesize httpConnect;

static IMNWManager *sharedNWManager = nil;

+ (IMNWManager*)sharedNWManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNWManager = [[self alloc] init];
    });
    return sharedNWManager;
}

- (void)initSocketConnect
{
    //static dispatch_once_t onceToken;
    //dispatch_once(&onceToken, ^{
        socketConnect = [[IMNWSocketConnect alloc] initWithHost:SOCKET_HOST port:SOCKET_PORT];
    //});
}

- (void)initHttpConnect
{
    httpConnect = [[IMNWHttpConnect alloc] initWithHostName:HTTP_HOST portNumber:HTTP_PORT apiPath:nil customHeaderFields:nil];
}

- (void)sendMessage:(IMNWMessage *)message withResponse:(imNWResponseBlock)response
{
    switch (message.connect) {
        case CONNECT_HTTP:
        {
            [self.httpConnect sendHttpRequest:message withResponse:response];
            break;
        }
        case CONNECT_SOCKET:
        {
            NSData *data = [message getSocketData];
            [self.socketConnect sendData:data];
            break;
        }
        default:
            break;
    }
}

- (void)parseMessage:(IMNWMessage *)message
{
    [message excute];
}

@end
