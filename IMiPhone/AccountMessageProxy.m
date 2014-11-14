//
//  AccountMessageProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AccountMessageProxy.h"
#import "UserDataProxy.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
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
    [UserDataProxy sharedProxy].mobCountry = country;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:country forKey:KEYQ_H__ACCOUNT_MOBCODE__MOBCOUNTRY];
    [params setObject:phone forKey:KEYQ_H__ACCOUNT_MOBCODE__MOBILE];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACCOUNT_MOBCODE_ withParams:params withMethod:METHOD_H__ACCOUNT_MOBCODE_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__ACCOUNT_MOBCODE__ERROR_CODE] intValue];
            if (errorcode == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACCOUNT_MOBCODE_ object:nil];
            }
            else {
                [self processErrorCode:errorcode fromSource:PATH_H__ACCOUNT_MOBCODE_ useNotiName:NOTI_H__ACCOUNT_MOBCODE_];
            }
        }
    }];
}

- (void)sendTypeRegister:(NSString *)password
{
    //使用http
    [UserDataProxy sharedProxy].password = password;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[UserDataProxy sharedProxy].mobcode forKey:KEYQ_H__ACCOUNT_REGISTER__MOBCODE];
    [params setObject:password forKey:KEYQ_H__ACCOUNT_REGISTER__PASSWORD];
    [params setObject:[UserDataProxy sharedProxy].mobile forKey:KEYQ_H__ACCOUNT_REGISTER__MOBILE];
    [params setObject:[UserDataProxy sharedProxy].mobCountry forKey:KEYQ_H__ACCOUNT_REGISTER__MOBCOUNTRY];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACCOUNT_REGISTER_ withParams:params withMethod:METHOD_H__ACCOUNT_REGISTER_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__ACCOUNT_MOBCODE__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSInteger uid = [[json objectForKey:KEYP_H__ACCOUNT_REGISTER__UID] integerValue];
                [UserDataProxy sharedProxy].lastLoginCountry = [UserDataProxy sharedProxy].mobCountry;
                [UserDataProxy sharedProxy].lastLoginMobile = [UserDataProxy sharedProxy].mobile;
                [UserDataProxy sharedProxy].lastLoginUid = uid;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACCOUNT_REGISTER_ object:nil userInfo:nil];
            }
            else {
               [self processErrorCode:errorcode fromSource:PATH_H__ACCOUNT_REGISTER_ useNotiName:NOTI_H__ACCOUNT_REGISTER_];
            }
        }
    }];
}

- (void)sendHttpLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password
{
    //使用http
    [UserDataProxy sharedProxy].lastLoginCountry = mobCountry;
    [UserDataProxy sharedProxy].lastLoginMobile = mobile;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:mobile forKey:KEYQ_H__ACCOUNT_LOGIN__MOBILE];
    [params setObject:mobCountry forKey:KEYQ_H__ACCOUNT_LOGIN__MOBCOUNTRY];
    [params setObject:password forKey:KEYQ_H__ACCOUNT_LOGIN__PASSWORD];
    [params setObject:[[UIDevice currentDevice] identifierForVendor].UUIDString forKey:KEYQ_H__ACCOUNT_LOGIN__UUID];
    [params setObject:[UIDevice currentDevice].systemName forKey:KEYQ_H__ACCOUNT_LOGIN__PLAT];
    [params setObject:[UIDevice currentDevice].systemVersion forKey:KEYQ_H__ACCOUNT_LOGIN__OSVERSION];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACCOUNT_LOGIN_ withParams:params withMethod:METHOD_H__ACCOUNT_LOGIN_ ssl:NO ];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__ACCOUNT_LOGIN__ERROR_CODE] intValue];
            if (errorcode == 0) {
                long long uid = [[json objectForKey:KEYP_H__ACCOUNT_LOGIN__UID] longLongValue];
                NSString *verify = [json objectForKey:KEYP_H__ACCOUNT_LOGIN__VERIFY];
                [UserDataProxy sharedProxy].verify = verify;
                [UserDataProxy sharedProxy].lastLoginUid = uid;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACCOUNT_LOGIN_ object:nil];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:[NSString stringWithFormat:NSLocalizedString(@"Alert.LoginError", nil), errorcode] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alertView show];
                [self processErrorCode:errorcode fromSource:PATH_H__ACCOUNT_LOGIN_ useNotiName:NOTI_H__ACCOUNT_LOGIN_];
            }
        }
    }];
}

- (void)sendTypeMyinfo
{
    //使用http
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACCOUNT_MYINFO_ withParams:nil withMethod:METHOD_H__ACCOUNT_MYINFO_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__ACCOUNT_MYINFO__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSMutableDictionary *uinfo = [json objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO];
                [UserDataProxy sharedProxy].user.uid = [[uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_UID] integerValue];;
                [UserDataProxy sharedProxy].user.oid = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_OID];
                [UserDataProxy sharedProxy].user.nick = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_NICK];
                [UserDataProxy sharedProxy].user.mobile = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_MOBILE];
                [UserDataProxy sharedProxy].user.mobCountry = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_MOBCOUNTRY];
                [UserDataProxy sharedProxy].user.email = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_EMAIL];
                [UserDataProxy sharedProxy].user.gender = [[uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_GENDER] integerValue];
                [UserDataProxy sharedProxy].user.city = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_CITY];
                [UserDataProxy sharedProxy].user.status = [[uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_STATUS] integerValue];
                [UserDataProxy sharedProxy].user.vip = [[uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_VIP] integerValue];
                [UserDataProxy sharedProxy].user.birthday = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_BIRTHDAY];
                [UserDataProxy sharedProxy].user.lunarbirth = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_LUNARBIRTH];
                [UserDataProxy sharedProxy].user.career = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_CAREER];
                [UserDataProxy sharedProxy].user.interest = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_INTEREST];
                [UserDataProxy sharedProxy].user.intro = [uinfo objectForKey:KEYP_H__ACCOUNT_MYINFO__UINFO_INTRO];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACCOUNT_MYINFO_ object:nil];
            }
            else {
                [self processErrorCode:errorcode fromSource:PATH_H__ACCOUNT_MYINFO_ useNotiName:NOTI_H__ACCOUNT_MYINFO_];
            }

        }
    }];
}

- (void)sendTypeUpdateinfo:(NSInteger)gender birthday:(NSString *)birth nickname:(NSString *)nick
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:gender] forKey:KEYQ_H__ACCOUNT_UPDATEINFO__GENDER];
    [params setObject:birth forKey:KEYQ_H__ACCOUNT_UPDATEINFO__BIRTHDAY];
    [params setObject:nick forKey:KEYQ_H__ACCOUNT_UPDATEINFO__NICK];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACCOUNT_UPDATEINFO_ withParams:params withMethod:METHOD_H__ACCOUNT_UPDATEINFO_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP_H__ACCOUNT_UPDATEINFO__ERROR_CODE] intValue];
            if (errorcode == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACCOUNT_UPDATEINFO_ object:nil];
            }
            else {
                [self processErrorCode:errorcode fromSource:PATH_H__ACCOUNT_UPDATEINFO_ useNotiName:NOTI_H__ACCOUNT_UPDATEINFO_];
            }
        }
    }];
}

- (void)sendTypeLogin
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[UserDataProxy sharedProxy].verify forKey:KEYQ_S_ACCOUNT_LOGIN_VERIFY];
    IMNWMessage *message = [IMNWMessage createForSocket:MARK_ACCOUNT withType:TYPE_S_ACCOUNT_LOGIN];
    [message send:params];
}

- (void)parseTypeLogin:(id)json
{
    NSMutableDictionary *info = [json objectForKey:SOCKET_INFO];
    int res = [[info objectForKey:KEYP_S_ACCOUNT_LOGIN_RES] intValue];
    if (res == RES_OK) {
        NSLog(@"%@",json);
        NSInteger uid = [[info objectForKey:KEYP_S_ACCOUNT_LOGIN_UID] integerValue];
        [UserDataProxy sharedProxy].lastLoginUid = uid;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_S_ACCOUNT_LOGIN object:nil];
    }
    else {
        [self processErrorCode:res fromSource:[NSString stringWithFormat:@"%@_%@", MARK_ACCOUNT, TYPE_S_ACCOUNT_LOGIN] useNotiName:NOTI_S_ACCOUNT_LOGIN];
    }
}

@end
