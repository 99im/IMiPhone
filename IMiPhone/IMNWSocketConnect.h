//
//  imNWSocketConnect.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

#define NOTI_SOCKET_CONNECT @"NWSocketConnectNotifiction"

@interface IMNWSocketConnect : NSObject

@property (nonatomic, retain) GCDAsyncSocket *socket;

- (id)initWithHost:(NSString *)hostIP port:(uint16_t)hostPort;

- (void)connect:(NSString *)hostIP port:(uint16_t)hostPort;

- (void)disconnect;

- (void)handlerData:(NSData *)data;

- (void)sendData:(NSData *)data;

@end
