//
//  DBUserFromContact.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBUserFromContact.h"

@implementation DBUserFromContact

@synthesize uid;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
