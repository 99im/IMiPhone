//
//  DPSysMessageGroup.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-31.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessage.h"

#define GROUP_MSG_TYPE_INVITE 1             //加群:邀请
#define GROUP_MSG_TYPE_APPLY 2              //加群:申请
#define GROUP_MSG_TYPE_APPLY_RESPONSE 3     //加群:响应申请
#define GROUP_MSG_TYPE_INVITE_RESPONSE 4    //加群:响应邀请 ???

#define GROUP_ST_APPLY_PENDING 0    //加群-申请状态：待处理
#define GROUP_ST_APPLY_PASSED 1     //加群-申请状态：已通过
#define GROUP_ST_APPLY_REFUSED 2    //加群-申请状态：已拒绝

#define GROUP_ST_INVITE_PENDING 0    //加群-申请状态：待处理 ???
#define GROUP_ST_INVITE_PASSED 1     //加群-申请状态：已通过 ???
#define GROUP_ST_INVITE_REFUSED 2    //加群-申请状态：已拒绝 ???

@interface DPSysMessageGroup : DPSysMessage

#pragma mark - 通用属性
@property (nonatomic) long long userId;
@property (nonatomic, retain) NSString *userNick;
@property (nonatomic) long long groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic) NSInteger status;

#pragma mark - 特定属性
@property (nonatomic) long long rid;    //申请加群

@end
