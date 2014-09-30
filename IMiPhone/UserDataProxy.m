//
//  MyClass.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserDataProxy.h"
#import "imRms.h"
#import "DatabaseConfig.h"
#import "ImDataUtil.h"

#define KEY_USER_LAST_LOGIN_COUNTRY @"key_user_last_login_country"
#define KEY_USER_LAST_LOGIN_MOBILE @"key_user_last_login_mobile"
#define KEY_USER_LAST_LOGIN_OID @"key_user_last_login_oid"
#define KEY_USER_LAST_LOGIN_UID @"key_user_last_login_uid"
#define KEY_USER_VERIFY @"key_user_verify"
#define KEY_USER_INFO_PRE @"key_user_info_"

@implementation UserDataProxy

@synthesize lastLoginCountry = _lastLoginCountry;
@synthesize lastLoginMobile = _lastLoginMobile;
@synthesize lastLoginOid = _lastLoginOid;
@synthesize lastLoginUid = _lastLoginUid;
@synthesize verify = _verify;
@synthesize user = _user;
@synthesize mobcode = _mobcode;
@synthesize mobCountry = _mobCountry;
@synthesize mobile = _mobile;
@synthesize password = _password;

@synthesize arrSearchUserResult;

static UserDataProxy *sharedProxy = nil;
+ (UserDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[UserDataProxy alloc] init];
    });
    return sharedProxy;
}

- (id)init
{
    if((self = [super init]))
    {
        _lastLoginUid = NAN;
    }
    return self;
}

- (NSString *)getLastLoginCountry
{
    if (_lastLoginCountry == nil)
        _lastLoginCountry = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_COUNTRY isBindUid:NO];
    return _lastLoginCountry;
}
- (void)setLastLoginCountry:(NSString *)lastLoginCountry
{
    _lastLoginCountry = lastLoginCountry;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_COUNTRY withStringValue:_lastLoginCountry isBindUid:NO];
}

- (NSString *)getLastLoginMobile
{
    if (_lastLoginMobile == nil) {
        _lastLoginMobile = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_MOBILE isBindUid:NO];
    }

    return _lastLoginMobile;
}
- (void)setLastLoginMobile:(NSString *)lastLoginMobile
{
    _lastLoginMobile = lastLoginMobile;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_MOBILE withStringValue:_lastLoginMobile isBindUid:NO];
}

- (NSString *)getLastLoginOid
{
    if (_lastLoginOid == nil) {
        _lastLoginOid = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_OID isBindUid:NO];
    }
    return _lastLoginOid;
}
- (void)setLastLoginOid:(NSString *)lastLoginOid
{
    _lastLoginOid = lastLoginOid;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_OID withStringValue:_lastLoginOid isBindUid:NO];
}

- (NSInteger)getLastLoginUid
{
    if (_lastLoginUid == NAN)
        _lastLoginUid = [imRms userDefaultsReadInt:KEY_USER_LAST_LOGIN_UID isBindUid:NO];
    return _lastLoginUid;
}
- (void)setLastLoginUid:(NSInteger)lastLoginUid
{
    _lastLoginUid = lastLoginUid;
    [DatabaseConfig shareDatabaseConfig].databaseName = [NSString stringWithFormat:@"%d", _lastLoginUid];
    [imRms setUid:_lastLoginUid];
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_UID withStringValue:[NSString stringWithFormat:@"%d", _lastLoginUid] isBindUid:NO];
}

- (NSString *)getVerify
{
    if (_verify == nil) {
        _verify = [imRms userDefaultsReadString:KEY_USER_VERIFY isBindUid:NO];
    }
    return _verify;
}
- (void)setVerify:(NSString *)value
{
    _verify = value;
    [imRms userDefaultsWrite:KEY_USER_VERIFY withStringValue:_verify isBindUid:NO];
}

- (DPUser *)getUser
{
    if (_user == nil) {
        _user = [[DPUser alloc] init];
        NSDictionary *userInfoDic = (NSDictionary *)[imRms userDefaultsReadObject:KEY_USER_INFO_PRE isBindUid:YES];
        if (userInfoDic == nil)
        {
            _user.uid = _lastLoginUid;
            [imRms userDefaultsWrite:KEY_USER_INFO_PRE withObjectValue:[ImDataUtil getDicFromNormalClass:_user] isBindUid:YES];
        }
        else
        {
            [ImDataUtil updateObject:_user by:userInfoDic];
        }
    }
    return _user;
}
- (void)setUser:(DPUser *)userInfo
{
    _user = userInfo;
    NSDictionary *userInfoDic = [ImDataUtil getDicFromNormalClass:_user];
    [imRms userDefaultsWrite:KEY_USER_INFO_PRE withObjectValue:userInfoDic isBindUid:YES];
}

@end
