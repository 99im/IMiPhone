//
//  ContactDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ContactDAO.h"

@implementation ContactDAO

static ContactDAO* sharedContactDAO = nil;

+ (ContactDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedContactDAO = [[self alloc] init];
                      NSString *tableName = @"tb_contact";
                      NSString *primaryKey = DB_PRIMARY_KEY_CONTACT_PERSON_PHONE;
                      [sharedContactDAO createTableIfNotExist:tableName withDataMode:[DBContactPerson class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedContactDAO;
}

@end
