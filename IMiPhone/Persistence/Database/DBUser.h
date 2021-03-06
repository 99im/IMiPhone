//
//  DBUser.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_USER_UID @"uid"

@interface DBUser : NSObject

@property (nonatomic) long long uid;
@property (nonatomic, retain) NSString *oid;
@property (nonatomic, retain) NSString *nick;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *mobCountry;
@property (nonatomic, retain) NSString *email;
@property (nonatomic) NSInteger gender;
@property (nonatomic, retain) NSString *city;
@property (nonatomic) NSInteger status;
@property (nonatomic) NSInteger vip;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *lunarbirth;
@property (nonatomic, retain) NSString *career;
@property (nonatomic, retain) NSString *interest;
@property (nonatomic, retain) NSString *intro;

@end
