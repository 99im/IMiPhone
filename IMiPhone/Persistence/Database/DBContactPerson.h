//
//  DBContactPerson.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_CONTACT_PERSON_PHONE @"phones"

@interface DBContactPerson : NSObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *phones;
@property (nonatomic, retain) NSString *emails;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) NSString *department;
@property (nonatomic        ) double birthday;
@property (nonatomic, retain) NSString *blogUrls;

@end
