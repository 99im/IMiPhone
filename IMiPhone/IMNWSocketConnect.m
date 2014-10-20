//
//  imNWSocketConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWSocketConnect.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "crypt.h"
#import "AccountMessageProxy.h"

#define TAG_MSG 0
#define TAG_CRYPT 1

#define SOCKET_TIMEOUT 10.0

@interface IMNWSocketConnect ()

@property (nonatomic, retain) NSString *host;
@property (nonatomic) NSInteger port;
@property (nonatomic, retain) NSData *dataToSend;

@end

@implementation IMNWSocketConnect

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
    self.host = hostIP;
    self.port = hostPort;
    
    NSError *err = nil;
    if(![self.socket connectToHost:hostIP onPort:hostPort withTimeout:SOCKET_TIMEOUT error:&err])
    {
        NSLog(@"Socket connect error: %@", err);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SOCKET_CONNECT object:err];
        self.dataToSend = nil;
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
    if (!CRYPT) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTypeLogin:) name:NOTI_S_ACCOUNT_LOGIN object:nil];
        [[AccountMessageProxy sharedProxy] sendTypeLogin];
    }
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == TAG_MSG) {
        [self handlerData:data];
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
    }
    else if (tag == TAG_CRYPT) {
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Socket Received CRYPT: %@", content);
        char originalKey[17];
        [data getBytes:originalKey length:data.length];
        keyRevert(originalKey, cryptKey);
        [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTypeLogin:) name:NOTI_S_ACCOUNT_LOGIN object:nil];
        [[AccountMessageProxy sharedProxy] sendTypeLogin];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sender withError:(NSError *)err
{
    NSLog(@"Socket disconnect with error: %@", err);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SOCKET_CONNECT object:err];
    self.dataToSend = nil;
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
    IMNWMessage *message = [[IMNWMessage alloc] init];
    message.data = json;
    message.mark = [json objectForKey:@"mark"];
    message.type = [json objectForKey:@"type"];
    [[IMNWManager sharedNWManager] parseMessage:message];
    
    [self.socket readDataToData:term withTimeout:-1 tag:TAG_MSG];
}

- (void)sendData:(NSData *)data
{
    if (self.socket.isDisconnected) {
        self.dataToSend = data;
        [self connect:self.host port:self.port];
    }
    else if (self.socket.isConnected) {
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Socket Send: %@ , length: %i", content, data.length);
        if (CRYPT) {
            cryptKey[0] = rand() % 127 + 1;
            cryptKey[1] = rand() % 127 + 1;
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
}

- (void)socket:(GCDAsyncSocket *)sender didWriteDataWithTag:(long)tag
{
    if (tag == TAG_MSG) {
        NSLog(@"Socket Send !!!");
    }
}

- (void)sendTypeLogin:(NSNotification *)notification
{
    if (notification.object) {
        [self.socket disconnect];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SOCKET_CONNECT object:notification.object];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SOCKET_CONNECT object:nil];
        if (self.dataToSend) {
            [self sendData:self.dataToSend];
        }
    }
    
    self.dataToSend = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_S_ACCOUNT_LOGIN object:nil];
}

@end
