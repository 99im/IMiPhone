//
//  DPSysMessageGroup.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-31.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessageGroup.h"

@interface DPSysMessageGroup ()

@property (nonatomic, retain) NSDictionary *msgParams;

@end

@implementation DPSysMessageGroup

@synthesize msgParams = _msgParams;

#pragma mark - 通用属性
@synthesize userId;
@synthesize userNick;
@synthesize groupId;
@synthesize groupName;
@synthesize status;

#pragma mark - 特定属性
@synthesize rid;

#pragma mark - 基类方法实现
- (NSDictionary *)getParamsDictionary
{
    return _msgParams;
}

- (void)setParamsProperty:(NSDictionary *)params
{
    NSInteger type = self.type;
    //NSLog(@"Group message id:%qi \ntype: %i \nparams: %@", self.smid, self.type , params);
    if (type == GROUP_MSG_TYPE_INVITE) {

        self.userId = [[params objectForKey:@"uid"] longLongValue];
        // self.rid = [[params objectForKey:@"rid"] longLongValue];
        // self.userName = [params objectForKey:@"userName"];
        // self.userName = [params objectForKey:@"groupName"];
    }
    else if (type == GROUP_MSG_TYPE_APPLY) {
        self.rid = [[params objectForKey:@"rid"] longLongValue];
        self.status = [[params objectForKey:@"status"] integerValue];

        NSDictionary *info = [params objectForKey:@"groupInfo"];
        self.groupId = [[info objectForKey:@"gid"] longLongValue];
        self.groupName = [info objectForKey:@"name"];

        info = [params objectForKey:@"uinfo"];
        self.userId = [[info objectForKey:@"uid"] longLongValue];
        self.userNick = [info objectForKey:@"nick"];
    }
    else if (type == GROUP_MSG_TYPE_APPLY_RESPONSE) {
        self.rid = [[params objectForKey:@"rid"] longLongValue];
        self.status = [[params objectForKey:@"status"] integerValue];

        NSDictionary *info = [params objectForKey:@"groupInfo"];
        self.groupId = [[info objectForKey:@"gid"] longLongValue];
        self.groupName = [info objectForKey:@"name"];
    }
    _msgParams = params;
}
@end
