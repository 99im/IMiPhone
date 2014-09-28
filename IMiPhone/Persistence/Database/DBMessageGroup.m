//
//  DBMessageGroup.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBMessageGroup.h"

@implementation DBMessageGroup

@synthesize messageGroupId;
@synthesize ownerId;
@synthesize type;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
