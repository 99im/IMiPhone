//
//  Group.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_GROUP_ID @"groupId"

@interface DBGroup : NSObject

@property (nonatomic) NSInteger  groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *members;
@property (nonatomic, retain) NSString *portraitUrl;//头像地址

@end
