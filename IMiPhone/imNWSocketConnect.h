//
//  imNWSocketConnect.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "imNWManager.h"

@interface imNWSocketConnect : NSObject

@property (nonatomic, retain) GCDAsyncSocket *socket;

- (void)connect:(NSString *)hostIP port:(uint16_t)hostPort;

- (void)handlerData:(NSData *)data;

- (void)sendData:(NSData *)data;

@end
