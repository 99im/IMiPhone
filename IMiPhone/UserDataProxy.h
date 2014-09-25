//
//  MyClass.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPUser.h"

@interface UserDataProxy : NSObject

@property (nonatomic, retain, getter=getLastLoginCountry, setter=setLastLoginCountry:) NSString *lastLoginCountry;
@property (nonatomic, retain, getter=getLastLoginMobile, setter=setLastLoginMobile:) NSString *lastLoginMobile;
@property (nonatomic, retain, getter=getLastLoginOid, setter=setLastLoginOid:) NSString *lastLoginOid;
@property (nonatomic, getter=getLastLoginUid, setter=setLastLoginUid:) NSInteger lastLoginUid;
@property (nonatomic, retain, getter=getVerify, setter=setVerify:) NSString *verify;
@property (nonatomic, retain) DPUser *user;
@property (nonatomic) NSUInteger uid;
@property (nonatomic, retain) NSString *mobcode;
@property (nonatomic, retain) NSString *mobCountry;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *password;

+ (UserDataProxy *)sharedProxy;

- (void)initUserFromRms;
- (void)updateUser:(DPUser *)userInfo;

@end
