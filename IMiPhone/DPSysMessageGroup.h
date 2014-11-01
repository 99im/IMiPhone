//
//  DPSysMessageGroup.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-31.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessage.h"

@interface DPSysMessageGroup : DPSysMessage

#pragma mark - 通用属性
@property (nonatomic) long long userId;
@property (nonatomic, retain) NSString *userNick;
@property (nonatomic) long long groupId;
@property (nonatomic, retain) NSString *groupName;

#pragma mark - 特定属性
@property (nonatomic) long long rid;    //申请加群

@end