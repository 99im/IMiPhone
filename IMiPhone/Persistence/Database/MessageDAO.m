//
//  MessageDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MessageDAO.h"

@implementation MessageDAO

static MessageDAO *messageDAO = nil;

+ (MessageDAO *)sharedDAO
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDAO = [[MessageDAO alloc] init];
        NSString *tableName = @"tb_message";
        NSString *primaryKey = DB_PRIMARY_KEY_SENDER_ID;
        [messageDAO createTableIfNotExist:tableName withDataMode:[DBMessage class] withPrimaryKey:primaryKey];
    });
    return messageDAO;
}

@end
