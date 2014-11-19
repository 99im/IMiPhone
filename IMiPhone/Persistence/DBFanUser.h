//
//  DBFanUser.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_FAN_USER_ORDERID @"orderId"

@interface DBFanUser : NSObject

@property (nonatomic) NSInteger orderId;

@property (nonatomic) long long fanUid;//用户id
@property (nonatomic, retain) NSString *byName;//别名
@property (nonatomic, retain) NSString *memo;//备注
@property (nonatomic, retain) NSString *groups;// 分组信息
@property (nonatomic) NSInteger relation;// 关系
@property (nonatomic) NSInteger isFriends;// 是否是好友

@end
