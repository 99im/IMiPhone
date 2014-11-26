//
//  Group.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPGroup.h"

@implementation DPGroup

@synthesize gid;
@synthesize name;
@synthesize categoryId;
@synthesize categoryName;
@synthesize memberNum;
@synthesize myRelation;
@synthesize ctime;
@synthesize intro;
@synthesize portraitUrl;

@synthesize creator_uid;
@synthesize creator_nick;
@synthesize creator_oid;
@synthesize creator_vip;
@synthesize creator_city;

@synthesize latitude;
@synthesize longitude;
@synthesize altitude;
@synthesize address;

@synthesize localExpireTime;
//@synthesize isInMyGroups;

//-(BOOL)isExpired
//{
//    return NO;
//}

-(BOOL)isGroupOK
{
    return YES;
}

-(BOOL)isGroupOwner
{
    if (self.myRelation == GROUP_RELATION_OWNER) {
        return YES;
    }
    return NO;
}

-(BOOL)isGroupManager
{
    if (self.myRelation == GROUP_RELATION_MEMBER || [self isGroupOwner]) {
        return YES;
    }
    return NO;
}

-(BOOL)isGroupMember
{
    if (self.myRelation == GROUP_RELATION_MEMBER || [self isGroupManager]) {
        return YES;
    }
    return NO;
}

-(BOOL)isGroupApplicant
{
    if (self.myRelation == GROUP_RELATION_APPLICANT) {
        return YES;
    }
    return NO;
}

-(BOOL)canGroupApply
{
    if (![self isGroupMember] && ![self isGroupApplicant]) {
        return YES;
    }
    return NO;
}
@end