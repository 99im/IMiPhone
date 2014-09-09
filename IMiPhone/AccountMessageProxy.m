//
//  AccountMessageProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AccountMessageProxy.h"
#import "imNWMessage.h"

@implementation AccountMessageProxy

static AccountMessageProxy *sharedAccountMessageProxy = nil;

+ (imNWProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAccountMessageProxy = [[self alloc] init];
    });
    return sharedAccountMessageProxy;
}

- (void)sendTypeMobcode:(NSString *)code withCountry:(NSString *)country
{
    imNWMessage *message = [imNWMessage createForSocket:MARK_ACCOUNT withType:@"mobcode"];
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:@"test" forKey:@"token"];
    [info setObject:@"1_ty0717" forKey:@"verify"];
    [message send:info];
}

- (void)parseTypeMobcode:(id)json
{
    
}

@end
