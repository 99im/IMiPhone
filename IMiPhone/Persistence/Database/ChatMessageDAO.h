//
//  MessageDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
#import "DBChatMessage.h"

@interface ChatMessageDAO : BaseDAO

+ (ChatMessageDAO*)sharedDAO;

- (NSInteger)primaryKeyMaxValue;

@end
