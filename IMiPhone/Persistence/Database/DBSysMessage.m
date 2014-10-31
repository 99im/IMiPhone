//
//  DBSysMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBSysMessage.h"

@implementation DBSysMessage

//@synthesize uid;
@synthesize  smid;
@synthesize  modid;
@synthesize  type;
@synthesize  ctime;
@synthesize params;

- (void)setParamsByDictionary:(NSDictionary *)dic
{
    self.params = [NSString stringWithFormat:@"%@",dic];
}

- (NSDictionary *)getDictionaryByParams:(NSString *)pParams
{
    if (pParams == nil) {
        return nil;
    }
    NSData *data = [pParams dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id dic = [NSJSONSerialization JSONObjectWithData:data
                 
                                             options:NSJSONReadingAllowFragments
                 
                                               error:&error];
    return dic;
}

@end
