//
//  MessageDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatMessageDAO.h"

@implementation ChatMessageDAO

static ChatMessageDAO *messageDAO = nil;

+ (ChatMessageDAO *)sharedDAO
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageDAO = [[ChatMessageDAO alloc] init];
        NSString *tableName = @"tb_message";
        NSString *primaryKey = DB_PRIMARY_KEY_CHAT_MESSAGE_NID;
        [messageDAO createTableIfNotExist:tableName withDataMode:[DBChatMessage class] withPrimaryKey:primaryKey];
    });
    return messageDAO;
}

@end
