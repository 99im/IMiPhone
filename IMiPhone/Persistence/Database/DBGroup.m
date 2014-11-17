//
//  Group.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBGroup.h"

@implementation DBGroup

@synthesize gid;
@synthesize name;
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

@synthesize localExpireTime;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
