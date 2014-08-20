//
//  imNWSocketConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWSocketConnect.h"

@implementation imNWSocketConnect

- (id)init
{
    self = [super init];
    if(self){
        self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    return self;
}

- (void)connect:(NSString *)hostIP port:(int)hostPort
{
    
}

@end
