//
//  DBMessageGroup.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBUiMessage.h"

@implementation DBUiMessage

@synthesize orderid;
@synthesize mid;
@synthesize relationId;
@synthesize type;
@synthesize unreadNum;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
