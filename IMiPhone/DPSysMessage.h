//
//  DPSysMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBSysMessage.h"

@interface DPSysMessage : NSObject

@property (nonatomic) long long smid;
@property (nonatomic) NSInteger modid;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *ctime;

- (NSDictionary *)getParamsDictionary;

@end
