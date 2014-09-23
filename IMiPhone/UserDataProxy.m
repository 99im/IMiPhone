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
#import "DataUtil.h"

#define KEY_USER_LAST_LOGIN_COUNTRY @"key_user_last_login_country"
#define KEY_USER_LAST_LOGIN_MOBILE @"key_user_last_login_mobile"
#define KEY_USER_LAST_LOGIN_OID @"key_user_last_login_oid"
#define KEY_USER_VERIFY @"key_user_verify"
#define KEY_USER_INFO_PRE @"key_user_info_"


@implementation UserDataProxy

@synthesize lastLoginCountry = _lastLoginCountry;
@synthesize lastLoginMobile = _lastLoginMobile;
@synthesize lastLoginOid = _lastLoginOid;
@synthesize verify = _verify;
@synthesize user = _user;
@synthesize mobcode = _mobcode;
@synthesize countryCode = _countryCode;
@synthesize mobile = _mobile;
@synthesize uid = _uid;
@synthesize password = _password;

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
        self.verify = @"";
    }
    return self;
}

- (NSString *)getLastLoginCountry
{
    _lastLoginCountry = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_COUNTRY];
    return _lastLoginCountry;
}
- (void)setLastLoginCountry:(NSString *)lastLoginCountry
{
    _lastLoginCountry = lastLoginCountry;
    [DatabaseConfig shareDatabaseConfig].databaseName = _lastLoginCountry;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_COUNTRY withStringValue:_lastLoginCountry];
}

- (NSString *)getLastLoginMobile
{
    _lastLoginMobile = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_MOBILE];
    return _lastLoginMobile;
}
- (void)setLastLoginMobile:(NSString *)lastLoginMobile
{
    _lastLoginMobile = lastLoginMobile;
    [DatabaseConfig shareDatabaseConfig].databaseName = _lastLoginMobile;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_MOBILE withStringValue:_lastLoginMobile];
}

- (NSString *)getLastLoginOid
{
    _lastLoginOid = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_OID];
    return _lastLoginOid;
}
- (void)setLastLoginOid:(NSString *)lastLoginOid
{
    _lastLoginOid = lastLoginOid;
    [DatabaseConfig shareDatabaseConfig].databaseName = _lastLoginOid;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_OID withStringValue:_lastLoginOid];
}

- (NSString *)getVerify
{
    _verify = [imRms userDefaultsReadString:KEY_USER_VERIFY];
    return _verify;
}
- (void)setVerify:(NSString *)value
{
    _verify = value;
    [imRms userDefaultsWrite:KEY_USER_VERIFY withStringValue:_verify];
}

- (void)initUserFromRms
{
    NSDictionary *userInfoDic = (NSDictionary *)[imRms userDefaultsReadObject:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginMobile]];
  if(_user == nil)
      _user = [[DPUser alloc] init];
  if(userInfoDic == nil)
   {
       _user.uid = _lastLoginMobile;
       [imRms userDefaultsWrite:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginMobile] withObjectValue:[DataUtil getDicFromNormalClass:_user]];
       ;
   }
   else
   {
       [DataUtil updateObject:_user by:userInfoDic];
   }
}
- (void)updateUser:(DPUser *)userInfo
{
    _user = userInfo;
    NSDictionary *userInfoDic = [DataUtil getDicFromNormalClass:_user];
    [imRms userDefaultsWrite:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginMobile] withObjectValue:userInfoDic];
}

@end
