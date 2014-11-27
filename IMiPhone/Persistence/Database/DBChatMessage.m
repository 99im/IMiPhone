//
//  GroupMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBChatMessage.h"

@implementation DBChatMessage

@synthesize nid;

@synthesize stage;
@synthesize mid;
@synthesize senderUid;
@synthesize targetId;
@synthesize msgType;
@synthesize content;
@synthesize sendTime;
@synthesize gid;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
