//
//  DPGroupMember.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPGroupMember.h"

@implementation DPGroupMember

@synthesize gid;
@synthesize uid;
@synthesize nick;
@synthesize relation;
@synthesize gender;
@synthesize oid;
@synthesize city;
@synthesize vip;

+(DPGroupMember *)create
{
    DPGroupMember *member = [[DPGroupMember alloc] init];
    return member;
}

-(NSString *)getLevelName
{
    NSString *lvName;
    if (self.relation == GROUP_RELATION_OWNER) {
        lvName = @"群主";
    } else if (self.relation == GROUP_RELATION_MANAGER) {
        lvName = @"管理员";
    } else if (self.relation == GROUP_RELATION_MEMBER) {
        lvName = @"群成员";
    } else {
        lvName = @"未定义";
    }
    return lvName;
}

-(NSString *)getGenderName
{
    if (self.gender == 0) {
        return @"男";
    }
    return @"女";
}

@end
