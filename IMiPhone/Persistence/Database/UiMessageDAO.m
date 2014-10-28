//
//  MessageDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UiMessageDAO.h"

@implementation UiMessageDAO

static UiMessageDAO *uiMessageDAO = nil;

+ (UiMessageDAO *)sharedDAO
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uiMessageDAO = [[UiMessageDAO alloc] init];
        NSString *tableName = @"tb_message_group";
        NSString *primaryKey = DB_PRIMARY_KEY_UI_MESSAGE_ORDER_ID;
        [uiMessageDAO createTableIfNotExist:tableName withDataMode:[DBUiMessage class] withPrimaryKey:primaryKey];
    });
    return uiMessageDAO;
}

@end
