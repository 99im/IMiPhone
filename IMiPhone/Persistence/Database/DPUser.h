//
//  User.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPUser : NSObject
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic) int gender;//性别
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *profile;//个人简介
@property (nonatomic, retain) NSString *portraitUrl;//头像本地url
@property (nonatomic, retain) NSString *lastLoginTime;

@end
