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
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_MOBCODE_ withParams:params withMethod:METHOD__ACCOUNT_MOBCODE_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            id objErrorCode = [json objectForKey:KEYP__ACCOUNT_MOBCODE__ERROR_CODE];
            int errorcode;
            if([objErrorCode isKindOfClass:[NSNumber class]])
            {
                errorcode = [objErrorCode intValue];
            }
            if (errorcode == 0) {
                
            }
            else {
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
            }
        }
    }];
}

- (void)sendTypeRegister:(NSString *)password
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
#warning 获取mobilecode
    [params setObject:@"" forKey:KEYQ__ACCOUNT_REGISTER__MOBCODE];
    [params setObject:password forKey:KEYQ__ACCOUNT_REGISTER__PASSWORD];
    //set phone
    //set country
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_REGISTER_ withParams:params withMethod:METHOD__ACCOUNT_REGISTER_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            
        }
    }];
}

- (void)sendTypeLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:KEYQ__ACCOUNT_LOGIN__MOBILE];
    [params setObject:mobCountry forKey:KEYQ__ACCOUNT_LOGIN__MOBCOUNTRY];
    [params setObject:password forKey:KEYQ__ACCOUNT_LOGIN__PASSWORD];
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_LOGIN_ withParams:params withMethod:METHOD__ACCOUNT_LOGIN_ ssl:NO ];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            id objErrorCode = [json objectForKey:KEYP__ACCOUNT_LOGIN__ERROR_CODE];
            int errorcode;
            if([objErrorCode isKindOfClass:[NSNumber class]])
            {
                errorcode = [objErrorCode intValue];
            }
            if (errorcode == 0) {
                NSString *uid = [json objectForKey:KEYP__ACCOUNT_LOGIN__UID];
                NSString *verify = [json objectForKey:KEYP__ACCOUNT_LOGIN__VERIFY];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:[NSString stringWithFormat:NSLocalizedString(@"Alert.LoginError", nil), errorcode] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alertView show];
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
            }
        }
    }];
}

- (void)sendTypeMyinfo:(NSString *)verify
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:verify forKey:KEYQ__ACCOUNT_MYINFO__VERIFY];
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_MYINFO_ withParams:params withMethod:METHOD__ACCOUNT_MYINFO_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            
        }
    }];
}

- (void)sendTypeUpdateinfo:(NSNumber *)gender birthday:(NSString *)birth nickname:(NSString *)nick
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:gender forKey:KEYQ__ACCOUNT_UPDATEINFO__GENDER];
    [params setObject:birth forKey:KEYQ__ACCOUNT_UPDATEINFO__BIRTHDAY];
    [params setObject:nick forKey:KEYQ__ACCOUNT_UPDATEINFO__NICK];
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_UPDATEINFO_ withParams:params withMethod:METHOD__ACCOUNT_UPDATEINFO_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            
        }
    }];
}

@end
