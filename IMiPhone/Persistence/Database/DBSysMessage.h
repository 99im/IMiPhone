//
//  DBSysMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_SYS_MSG_SMID @"smid"

@interface DBSysMessage : NSObject

@property (nonatomic) long long smid;
@property (nonatomic) NSInteger modid;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic, retain) NSString *params;

- (void)setParamsByDictionary:(NSDictionary *)dic;
- (NSDictionary *)getDictionaryByParams:(NSString *)params;

@end
