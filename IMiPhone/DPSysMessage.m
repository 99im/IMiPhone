//
//  DPSysMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessage.h"
#import "MsgMessageProxy.h"
#import "DPSysMessageFriend.h"
#import "DPSysMessageGroup.h"

@implementation DPSysMessage

@synthesize  smid;
@synthesize  modid;
@synthesize  type;
@synthesize  ctime;
@synthesize title;
@synthesize content;

+ (DPSysMessage *)sysMessageByMid:(long long)mid withMode:(NSInteger)modeid withType:(NSInteger)type withTime:(NSString *)time withTitle:(NSString *)title withContent:(NSString *)content
{
    DPSysMessage *dpSysMessage;
    if (modeid == SYS_MSG_MODE_FRIEND) {
        dpSysMessage = [[DPSysMessageFriend alloc] init];
    } else if(modeid == SYS_MSG_MODE_GROUP){
        dpSysMessage = [[DPSysMessageGroup alloc] init];
    }

    if (dpSysMessage) {
        dpSysMessage.smid = mid;
        dpSysMessage.modid = modeid;
        dpSysMessage.type = type;
        dpSysMessage.ctime = time;
        dpSysMessage.title = title;
        dpSysMessage.content = content;
        return dpSysMessage;
    }
    NSLog(@"没有找到对应modeid:%i和type:%i的DP数据模型",modeid,type);
    return nil;
}

- (NSDictionary *)getParamsDictionary
{
    NSLog(@"DPSysMessage getParamsDictionary 需要子类重写!!!");
    return nil;
}

- (void)setParamsProperty:(NSDictionary *)params
{
    NSLog(@"DPSysMessage setParamsProperty 需要子类重写!!!");
}

@end
