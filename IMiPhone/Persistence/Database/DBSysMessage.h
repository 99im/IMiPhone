//
//  DBSysMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_SYS_MSG_SMID @"smid"

@interface DBSysMessage : NSObject

@property (nonatomic) long uid;
@property (nonatomic) long smid;
@property (nonatomic, retain) NSString *modid;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) long targetId;
@property (nonatomic) long extraId;
@property (nonatomic, retain) NSString *content;
@property (nonatomic) NSInteger resultStatus;
@property (nonatomic) NSInteger extraStatus;
@property (nonatomic) NSInteger unread;


@end