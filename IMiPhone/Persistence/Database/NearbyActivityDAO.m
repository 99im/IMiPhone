//
//  NearbyActivityDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NearbyActivityDAO.h"

@implementation DBNearbyActivity

@synthesize nid;

@synthesize aid;
@synthesize ctime;//加入时间
@synthesize myReleation;

@end

@implementation NearbyActivityDAO

static NearbyActivityDAO* sharedNearbyActivityDAO = nil;

+ (NearbyActivityDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedNearbyActivityDAO = [[self alloc] init];
                      NSString *tableName = @"tb_nearby_activity";
                      NSString *primaryKey = DB_PRIMARY_KEY_NEARBY_ACTIVITY_NID;
                      [sharedNearbyActivityDAO createTableIfNotExist:tableName withDataMode:[DBNearbyActivity class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedNearbyActivityDAO;
}

@end
