//
//  ActivityMemberDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityMemberDAO.h"

@implementation DBActivityMember

@synthesize orderid;

@synthesize aid;
@synthesize ctime;
@synthesize uid;
@synthesize relation;

@end

@implementation ActivityMemberDAO

static ActivityMemberDAO* sharedActivityMemberDAO = nil;

+ (ActivityMemberDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedActivityMemberDAO = [[self alloc] init];
                      NSString *tableName = @"tb_activity_member";
                      NSString *primaryKey = DB_PRIMARY_KEY_ACTIVITY_MEMBER_ORDERID;
                      [sharedActivityMemberDAO createTableIfNotExist:tableName withDataMode:[DBActivityMember class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedActivityMemberDAO;
}

@end
