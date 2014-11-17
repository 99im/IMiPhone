//
//  DBContactPerson.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBContactPerson.h"

@implementation DBContactPerson

@synthesize firstName;
@synthesize lastName;
@synthesize phones;
@synthesize emails;
@synthesize company;
@synthesize nickName;
@synthesize department;
@synthesize birthday;
@synthesize blogUrls;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefine key ---%@",key);
}

@end
