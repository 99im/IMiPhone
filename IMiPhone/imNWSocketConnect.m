//
//  imNWSocketConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWSocketConnect.h"
#import "imNWMessage.h"
#import "imNWManager.h"
#import "crypt.h"

#define TAG_MSG 0
#define TAG_CRYPT 1

@implementation imNWSocketConnect

NSData *term = nil;
char cryptKey[17];

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
    if (CRYPT) {
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_CRYPT];
    }
    else {
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
    }
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
    else if (tag == TAG_CRYPT) {
        char originalKey[17];
        [data getBytes:originalKey length:data.length];
        keyRevert(originalKey, cryptKey);
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sender withError:(NSError *)err
{
    NSLog(@"Socket disconnect with error: %@", err);
}

- (void)handlerData:(NSData *)data
{
    NSData *dataDecoded = nil;
    if (CRYPT) {
        char *dataBytes = (char *)[data bytes];
        char bytesToDecode[data.length - 2];
        [data getBytes:bytesToDecode range:NSMakeRange(2, data.length - 3)];
        cryptKey[0] = dataBytes[0];
        cryptKey[1] = dataBytes[1];
        bitDecode(bytesToDecode , data.length - 3, cryptKey, 16);
        dataDecoded = [NSData dataWithBytes:bytesToDecode length:data.length - 3];
    }
    else {
        dataDecoded = data;
    }
    
    NSString *content = [[NSString alloc] initWithData:dataDecoded encoding:NSUTF8StringEncoding];
    NSLog(@"Socket Received: %@", content);

    NSError *err = nil;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:dataDecoded options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        NSLog(@"JSON create error: %@", err);
    }
    imNWMessage *message = [[imNWMessage alloc] init];
    message.data = json;
    message.mark = [json objectForKey:@"mark"];
    message.type = [json objectForKey:@"type"];
    [[imNWManager sharedNWManager] parseMessage:message];
    
    [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
}

- (void)sendData:(NSData *)data
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Socket Send: %@ , length: %i", content, data.length);
    if (CRYPT) {
        char *dataBytes = (char*)[data bytes];
        bitEncode(dataBytes, data.length, cryptKey, 16);
        NSMutableData *dataEncoded = [NSMutableData data];
        [dataEncoded appendBytes:cryptKey length:2];
        [dataEncoded appendBytes:dataBytes length:data.length];
        [self.socket writeData:dataEncoded withTimeout:-1 tag:TAG_MSG];
        [self.socket writeData:term withTimeout:-1 tag:TAG_MSG];
    }
    else {
        [self.socket writeData:data withTimeout:-1 tag:TAG_MSG];
    }
}

- (void)socket:(GCDAsyncSocket *)sender didWriteDataWithTag:(long)tag
{
    if (tag == TAG_MSG) {
        NSLog(@"Socket Send !!!");
    }
}

@end
