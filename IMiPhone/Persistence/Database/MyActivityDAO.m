//
//  MyActivity.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MyActivityDAO.h"

@implementation DBMyActivity

@synthesize nid;

@synthesize aid;
@synthesize ctime;//加入时间
@synthesize myReleation;

@end

@implementation MyActivityDAO

static MyActivityDAO* sharedMyActivityDAO = nil;

+ (MyActivityDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedMyActivityDAO = [[self alloc] init];
                      NSString *tableName = @"tb_my_activity";
                      NSString *primaryKey = DB_PRIMARY_KEY_MY_ACTIVITY_NID;
                      [sharedMyActivityDAO createTableIfNotExist:tableName withDataMode:[DBMyActivity class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedMyActivityDAO;
}

@end
