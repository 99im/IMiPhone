//
//  imNWManager.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWManager.h"

@implementation imNWManager

@synthesize socketConnect;
@synthesize httpConnect;

static imNWManager *sharedNWManager = nil;

+ (imNWManager*)sharedNWManager
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
        socketConnect = [[imNWSocketConnect alloc] init];
    //});
}

- (void)initHttpConnect
{
    httpConnect = [[imNWHttpConnect alloc] init];
}

- (void)sendMessage:(imNWMessage *)message withResponse:(imNWResponseBlock)response
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

- (void)parseMessage:(imNWMessage *)message
{
    [message excute];
//    Class markClass = NSClassFromString([NSString stringWithFormat:@"Mark%@", message.mark]);
//    SEL typeMethod = NSSelectorFromString([NSString stringWithFormat:@"parseType%@", message.type]);
//    [markClass performSelector:typeMethod withObject:nil];
}

@end
