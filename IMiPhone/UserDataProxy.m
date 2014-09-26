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
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_OID withStringValue:_lastLoginOid];
}

- (NSInteger)getLastLoginUid
{
    _lastLoginUid = [imRms userDefaultsReadInt:KEY_USER_LAST_LOGIN_UID];
    return _lastLoginUid;
}
- (void)setLastLoginUid:(NSInteger)lastLoginUid
{
    _lastLoginUid = lastLoginUid;
    [DatabaseConfig shareDatabaseConfig].databaseName = [NSString stringWithFormat:@"%d", _lastLoginUid];
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_UID withStringValue:[NSString stringWithFormat:@"%d", _lastLoginUid]];
    [self initUserFromRms];
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
    NSDictionary *userInfoDic = (NSDictionary *)[imRms userDefaultsReadObject:[KEY_USER_INFO_PRE stringByAppendingString:[NSString stringWithFormat:@"%d", _lastLoginUid]]];
  if(_user == nil)
      _user = [[DPUser alloc] init];
  if(userInfoDic == nil)
   {
       _user.uid = _lastLoginUid;
       [imRms userDefaultsWrite:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginMobile] withObjectValue:[DataUtil getDicFromNormalClass:_user]];
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
