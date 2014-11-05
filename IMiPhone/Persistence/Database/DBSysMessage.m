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
@synthesize title;
@synthesize content;

- (void)setParamsByDictionary:(NSDictionary *)dic
{
    NSError *error;

    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0  error:&error];
    self.params = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

}

- (NSDictionary *)getDictionaryByParams
{
    if (self.params == nil) {
        return [NSDictionary dictionary];
    }
    NSData *data = [self.params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id dic = [NSJSONSerialization JSONObjectWithData:data
                 
                                             options:NSJSONReadingAllowFragments
                 
                                               error:&error];
    return dic;
}

@end
