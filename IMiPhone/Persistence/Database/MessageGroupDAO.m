//
//  MessageDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MessageGroupDAO.h"
#import "DBMessageGroup.h"

@implementation MessageGroupDAO

static MessageGroupDAO *messageGroupDAO = nil;

+ (MessageGroupDAO *)sharedDAO
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageGroupDAO = [[MessageGroupDAO alloc] init];
        NSString *tableName = @"tb_message_group";
        NSString *primaryKey = @"messageGroupId";
        [messageGroupDAO createTableIfNotExist:tableName withDataMode:[DBMessageGroup class] withPrimaryKey:primaryKey];
    });
    return messageGroupDAO;
}

@end
