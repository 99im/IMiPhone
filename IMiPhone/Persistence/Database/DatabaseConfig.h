//
//  DatabaseConfig.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//



#define DATA_BASE_NAME @"im.sqlite"


@interface DatabaseConfig : NSObject

+ (DatabaseConfig *) instance;

@property (nonatomic, retain) NSString * databaseName;

@property (nonatomic, retain) NSDictionary *dicSQLDataType;

@end
