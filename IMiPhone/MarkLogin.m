//
//  MarkLogin.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MarkLogin.h"

@implementation MarkLogin

static MarkLogin *sharedMark = nil;

NSString *const TYPE_REGISTER = @"register";

+ (MarkLogin *)sharedMark
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMark = [[self alloc] init];
    });
    return sharedMark;
}

- (void)parseMessage:(imNWMessage *)message
{
    if ([message.type isEqualToString:TYPE_REGISTER] == YES) {
        [self parseTypeRegister:[message getResponseJson]];
    }
}

- (void)sendTypeRegister:(NSString *)phone code:(NSString *)code password:(NSString *)password
{
    
}

- (void)parseTypeRegister:(id)json
{
    
}

@end
