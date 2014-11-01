//
//  DPSysMessageGroup.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-31.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessageGroup.h"

#define GROUP_MSG_INVITE 1
#define GROUP_MSG_APPLY 2

@implementation DPSysMessageGroup

#pragma mark - 通用属性
@synthesize uid;
@synthesize userName;
@synthesize gid;
@synthesize groupName;

#pragma mark - 特定属性
@synthesize rid;

#pragma mark - 基类方法实现
- (NSDictionary *)getParamsDictionary {
  NSDictionary *dic = [ImDataUtil getDicFromNormalClass:self containSuper:NO];
  return dic;
}

- (void)setParamsPropertyByDic:(NSDictionary *)dic {
  NSDictionary *params = [dic objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_PARAMS];
  NSInteger type = self.type;
    if (type == GROUP_MSG_INVITE) {
        self.uid = [[params objectForKey:@"uid"] longLongValue];
        //self.rid = [[params objectForKey:@"rid"] longLongValue];
        //self.userName = [params objectForKey:@"userName"];
        //self.userName = [params objectForKey:@"groupName"];
    } else if (type == GROUP_MSG_APPLY) {
        //self.uid = [[params objectForKey:@"uid"] longLongValue];
        self.rid = [[params objectForKey:@"rid"] longLongValue];
        //self.userName = [params objectForKey:@"userName"];
        //self.userName = [params objectForKey:@"groupName"];
    }
}
@end
