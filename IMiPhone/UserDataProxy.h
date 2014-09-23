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

@property(getter = getLastLoginUserId,setter = setLastLoginUserId:) NSString *lastLoginUserId;
@property(getter = getVerify,setter = setVerify:) NSString *verify;
@property DPUser *user;



+ (UserDataProxy *)sharedProxy;

- (void)initUserFromRms;
- (void)updateUser:(DPUser *)userInfo;


@end
