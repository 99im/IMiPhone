//
//  imNWSocketConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWSocketConnect.h"

@implementation imNWSocketConnect

#define TAG_MSG 0

NSData *term = nil;

- (id)init
{
    self = [super init];
    if(self){
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        term = [@"\0" dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

- (void)connect:(NSString *)hostIP port:(uint16_t)hostPort
{
    NSError *err = nil;
    if(![self.socket connectToHost:hostIP onPort:hostPort error:&err])
    {
        NSLog(@"Socket connect error: %@", err);
    }
    
    [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"Socket connect succceed: %@ : %hu", host, port);
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == TAG_MSG) {
        [self handlerData:data];
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sender withError:(NSError *)err
{
    NSLog(@"Socket disconnect with error: %@", err);
}

- (void)handlerData:(NSData *)data
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Socket Received: %@", content);
}

- (void)sendData:(NSData *)data
{
    [self.socket writeData:data withTimeout:-1 tag:TAG_MSG];
}

@end
