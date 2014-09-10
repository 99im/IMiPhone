//
//  imNWProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWProxy.h"

@implementation imNWProxy

static imNWProxy *sharedNWProxy = nil;

+ (imNWProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNWProxy = [[self alloc] init];
    });
    return sharedNWProxy;
}

- (void)parseMessage:(imNWMessage *)message
{
    NSString *type = [message.type capitalizedString];
    NSString *method = [NSString stringWithFormat:@"parseType%@:", type];
    SEL selector = NSSelectorFromString(method);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.data];
    }
    else {
        NSAssert2(YES, @"%@MessageProxy has no such method: %@", [message.mark capitalizedString], method);
    }
}


@end
