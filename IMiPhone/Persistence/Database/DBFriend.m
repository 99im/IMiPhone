//
//  DBFriend.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBFriend.h"

@implementation DBFriend

@synthesize uid;
//@synthesize beFocusedTime;//被关注的时间
//@synthesize focusTime;//关注我的时间
@synthesize groups;
@synthesize memo;
@synthesize byName;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
