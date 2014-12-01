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

- (NSInteger)primaryKeyMaxValue
{
    SqlightResult *res;
    NSString *sql =  [NSString stringWithFormat:@"select max(%@) from %@", DB_PRIMARY_KEY_CHAT_MESSAGE_NID, self.tableName];

    res = [self.sqlight excuteSQL:sql bind:nil];
    if (res.code == SQLITE_DONE) {
        if (res.data && res.data.count > 0) {
            NSArray *rowData = [res.data objectAtIndex:0];
            if (rowData && rowData.count > 0) {
                NSString *max = [rowData objectAtIndex:0];
                if (max.length > 0) {
                    return [max integerValue];
                }
            }
        }
    }
    return 0;
}
//- (SqlightResult *)excuteSQL:(NSString *)aSQL bind:(NSArray *)aBind;


@end
