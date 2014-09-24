//
//  AccountMessageProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AccountMessageProxy.h"
#import "UserDataProxy.h"
#import "imNWMessage.h"
#import "imNWManager.h"
#import "NSNumber+IMNWError.h"

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
    [UserDataProxy sharedProxy].mobile = phone;
    [UserDataProxy sharedProxy].countryCode = country;
    
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
            int errorcode = [[json objectForKey:KEYP__ACCOUNT_MOBCODE__ERROR_CODE] intValue];
            if (errorcode == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__ACCOUNT_MOBCODE_ object:nil];
            }
            else {
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
                NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
                NSString *errorMessage = [errorCodeNumber errorMessage];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage
                                                                     forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:PATH__ACCOUNT_MOBCODE_ code:errorcode userInfo:userInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__ACCOUNT_MOBCODE_ object:error];
            }
        }
    }];
}

- (void)sendTypeRegister:(NSString *)password
{
    //使用http
    [UserDataProxy sharedProxy].password = password;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[UserDataProxy sharedProxy].mobcode forKey:KEYQ__ACCOUNT_REGISTER__MOBCODE];
    [params setObject:password forKey:KEYQ__ACCOUNT_REGISTER__PASSWORD];
    [params setObject:[UserDataProxy sharedProxy].mobile forKey:KEYQ__ACCOUNT_REGISTER__MOBILE];
    [params setObject:[UserDataProxy sharedProxy].countryCode forKey:KEYQ__ACCOUNT_REGISTER__MOBCOUNTRY];
    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_REGISTER_ withParams:params withMethod:METHOD__ACCOUNT_REGISTER_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP__ACCOUNT_MOBCODE__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSInteger uid = [[json objectForKey:KEYP__ACCOUNT_REGISTER__UID] integerValue];
                [UserDataProxy sharedProxy].uid = uid;
                [UserDataProxy sharedProxy].lastLoginCountry = [UserDataProxy sharedProxy].mobile;
                [UserDataProxy sharedProxy].lastLoginMobile = [UserDataProxy sharedProxy].countryCode;
            }
            else {
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
            }
        }
    }];
}

- (void)sendTypeLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password
{
    //使用http
    [UserDataProxy sharedProxy].lastLoginCountry = mobCountry;
    [UserDataProxy sharedProxy].lastLoginMobile = mobile;
    
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
            int errorcode = [[json objectForKey:KEYP__ACCOUNT_LOGIN__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSInteger uid = [[json objectForKey:KEYP__ACCOUNT_LOGIN__UID] integerValue];
                NSString *verify = [json objectForKey:KEYP__ACCOUNT_LOGIN__VERIFY];
                [UserDataProxy sharedProxy].uid = uid;
                [UserDataProxy sharedProxy].verify = verify;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__ACCOUNT_LOGIN_ object:nil];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:[NSString stringWithFormat:NSLocalizedString(@"Alert.LoginError", nil), errorcode] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alertView show];
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
                NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
                NSString *errorMessage = [errorCodeNumber errorMessage];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage
                                                                     forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:PATH__ACCOUNT_LOGIN_ code:errorcode userInfo:userInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__ACCOUNT_LOGIN_ object:error];
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
