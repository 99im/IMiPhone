//
//  DBMessageGroup.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_MESSAGE_PROUP_ID @"messageGroupId"

@interface DBMessageGroup : NSObject

@property (nonatomic, retain) NSString *messageGroupId;
@property (nonatomic, retain) NSString *ownerId;
@property (nonatomic)         NSInteger type;//私聊，群聊...

@end
