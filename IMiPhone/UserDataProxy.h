//
//  MyClass.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPUser.h"
#import "UserDAO.h"

#define NOTIFY_USER_DATA_PROXY_LAST_LOGIN_UID_CHANGE @"notify_user_data_proxy_last_login_uid_change"

@interface UserDataProxy : NSObject

@property (nonatomic, retain, getter=getLastLoginCountry, setter=setLastLoginCountry:) NSString *lastLoginCountry;
@property (nonatomic, retain, getter=getLastLoginMobile, setter=setLastLoginMobile:) NSString *lastLoginMobile;
@property (nonatomic, getter=getLastLoginUid, setter=setLastLoginUid:) long long lastLoginUid;
@property (nonatomic, retain, getter=getVerify, setter=setVerify:) NSString *verify;
@property (nonatomic, retain, getter=getUser, setter=setUser:) DPUser *user;
@property (nonatomic, retain) NSString *mobcode;
@property (nonatomic, retain) NSString *mobCountry;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *password;

@property (nonatomic) long long showUserInfoUid;
@property (nonatomic) NSInteger showUserInfoRleation;

+ (UserDataProxy *)sharedProxy;

- (void)reset;

- (NSMutableArray *)mutableArrayUsers;

//所有用户数据的相关操作
- (void)updateUser:(DPUser *)user;
- (DPUser *)getUserByUid:(long long) uid;
//- (void)delUserByUid:(NSInteger) uid;

- (void)addServerUinfo:(NSDictionary *)uinfo;

@end
