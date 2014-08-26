//
//  imNWMessage.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONNECT_HTTP 0
#define CONNECT_SOCKET 1

@interface imNWMessage : NSObject

@property (nonatomic) int connect;
@property (nonatomic, retain) NSString *mark;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) id data;
@property (nonatomic, retain) NSString *host;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, strong) NSMutableArray *responseBlocks;

- (NSData *)getSocketData;
- (NSMutableDictionary *)getHttpParams;
- (NSDictionary *)getResponseJson;
- (void)excute;

@end
