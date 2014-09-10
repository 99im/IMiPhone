//
//  AccountMessageProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AccountMessageProxy.h"
#import "imNWMessage.h"
#import "imNWManager.h"

@implementation AccountMessageProxy

static AccountMessageProxy *sharedAccountMessageProxy = nil;

+ (AccountMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAccountMessageProxy = [[self alloc] init];
    });
    return sharedAccountMessageProxy;
}

- (void)sendTypeMobcode:(NSString *)phone withCountry:(NSString *)country
{
    //使用https
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:country forKey:@"mobCountry"];
    [params setObject:phone forKey:@"mobile"];
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:@"/account/mobcode/" withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

@end
