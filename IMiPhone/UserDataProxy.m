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

#define KEY_USER_LAST_LOGIN_USER_ID @"key_user_last_login_id"
#define KEY_USER_VERIFY @"key_user_verify"

#define KEY_USER_INFO_PRE @"key_user_info_"


@implementation UserDataProxy
@synthesize lastLoginUserId = _lastLoginUserId;
@synthesize verify = _verify;
@synthesize user = _user;

static UserDataProxy *sharedProxy = nil;
+ (UserDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[UserDataProxy alloc] init];
    });
    return sharedProxy;
}
-(NSString *)getLastLoginUserId
{
    _lastLoginUserId = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_USER_ID];
    return _lastLoginUserId;
}
-(void)setLastLoginUserId:(NSString*)value
{
    _lastLoginUserId = value;
    [DatabaseConfig shareDatabaseConfig].databaseName = _lastLoginUserId;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_USER_ID withStringValue:_lastLoginUserId];
}
-(NSString *)getVerify
{
    _verify = [imRms userDefaultsReadString:KEY_USER_VERIFY];
    return _verify;
}
-(void)setVerify:(NSString*)value
{
    _verify = value;
    [imRms userDefaultsWrite:KEY_USER_VERIFY withStringValue:_verify];
}

-(void)initUserFromRms
{
    NSDictionary *userInfoDic = (NSDictionary *)[imRms userDefaultsReadObject:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginUserId]];
  if(_user == nil)
      _user = [[DPUser alloc] init];
  if(userInfoDic == nil)
   {
       _user.uid = _lastLoginUserId;
       [imRms userDefaultsWrite:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginUserId] withObjectValue:[DataUtil getDicFromNormalClass:_user]];
       ;
   }
   else
   {
       [DataUtil updateObject:_user by:userInfoDic];
   }
}
-(void)updateUser:(DPUser *)userInfo
{
    _user = userInfo;
    NSDictionary *userInfoDic = [DataUtil getDicFromNormalClass:_user];
    [imRms userDefaultsWrite:[KEY_USER_INFO_PRE stringByAppendingString:_lastLoginUserId] withObjectValue:userInfoDic];
}

@end
