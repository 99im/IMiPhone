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
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:country forKey:KEYQ__ACCOUNT_MOBCODE__MOBCOUNTRY];
    [params setObject:phone forKey:KEYQ__ACCOUNT_MOBCODE__MOBILE];
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:PATH__ACCOUNT_MOBCODE_ withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

- (void)sendTypeRegister:(NSString *)mobcode withPwd:(NSString *)password
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobcode forKey:KEYQ__ACCOUNT_REGISTER__MOBCODE];
    [params setObject:password forKey:KEYQ__ACCOUNT_REGISTER__PASSWORD];
    //set phone
    //set country
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:PATH__ACCOUNT_REGISTER_ withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

- (void)sendTypeLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:KEYQ__ACCOUNT_LOGIN__MOBILE];
    [params setObject:mobCountry forKey:KEYQ__ACCOUNT_LOGIN__MOBCOUNTRY];
    [params setObject:password forKey:KEYQ__ACCOUNT_LOGIN__PASSWORD];
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:PATH__ACCOUNT_LOGIN_ withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

- (void)sendTypeMyinfo:(NSString *)verify
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:verify forKey:KEYQ__ACCOUNT_MYINFO__VERIFY];
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:PATH__ACCOUNT_MYINFO_ withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

- (void)sendTypeUpdateinfo:(NSNumber *)gender birthday:(NSString *)birth nickname:(NSString *)nick
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:gender forKey:KEYQ__ACCOUNT_UPDATEINFO__GENDER];
    [params setObject:birth forKey:KEYQ__ACCOUNT_UPDATEINFO__BIRTHDAY];
    [params setObject:nick forKey:KEYQ__ACCOUNT_UPDATEINFO__NICK];
    imNWMessage *message = [imNWMessage createForHttp:HTTPSHOST onPath:PATH__ACCOUNT_UPDATEINFO_ withParams:params];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        ;
    }];
}

@end
