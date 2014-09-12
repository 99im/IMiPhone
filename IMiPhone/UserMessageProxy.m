//
//  MarkLogin.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserMessageProxy.h"

#define TYPE_REGISTER @"register"

@implementation UserMessageProxy

static UserMessageProxy *sharedUserMessageProxy = nil;

+ (UserMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserMessageProxy = [[self alloc] init];
    });
    return sharedUserMessageProxy;
}

- (void)sendTypeRegister:(NSString *)phone code:(NSString *)code password:(NSString *)password
{
    
}

- (void)parseTypeRegister:(id)json
{
    
}

@end
