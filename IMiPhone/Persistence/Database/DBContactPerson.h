//
//  DBContactPerson.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_CONTACT_PERSON_PHONE @"phone"

@interface DBContactPerson : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phone;

@end
