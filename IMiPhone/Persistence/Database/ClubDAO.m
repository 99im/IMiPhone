//
//  ClubDAO.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ClubDAO.h"

@implementation ClubDAO

static ClubDAO *shareClubDAO = nil;
+ (ClubDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareClubDAO = [[self alloc] init];
        NSString *tableName = @"tb_club";
        NSString *primaryKey = DB_PRIMARY_KEY_USER_UID;
        [shareClubDAO createTableIfNotExist:tableName withDataMode:[DBClub class] withPrimaryKey:primaryKey];
    });
    return shareClubDAO;
}

@end
