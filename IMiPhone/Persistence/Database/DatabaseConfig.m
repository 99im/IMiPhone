//
//  DatabaseConfig.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DatabaseConfig.h"


@implementation DatabaseConfig
+ (DatabaseConfig *) shareDatabaseConfig{
    static DatabaseConfig* _instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      _instance = [[self alloc] init];
                      _instance.dicSQLDataType = [NSDictionary dictionaryWithObjectsAndKeys:@"INTEGER",@"i",@"REAL",@"f",@"REAL",@"d",@"TEXT",@"NSString",nil];
                  }
                  );
    return _instance;
}

@end
