//
//  User.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *user_nick_name;
@property (nonatomic) int user_gender;//性别
@property (nonatomic, retain) NSString *user_phone;
@property (nonatomic, retain) NSString *user_address;
@property (nonatomic, retain) NSString *user_profile;//个人简介
@property (nonatomic, retain) NSString *user_portrait_url;//头像本地url
@property (nonatomic, retain) NSString *user_last_login_time;

@end
