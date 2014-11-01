//
//  DPSysMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBSysMessage.h"
#import "ImDataUtil.h"
#import "MsgMessageProxy.h"

@interface DPSysMessage : NSObject

@property (nonatomic) long long smid;
@property (nonatomic) NSInteger modid;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;


+ (DPSysMessage *)sysMessageByMid:(long long)mid withMode:(NSInteger)modeid withType:(NSInteger)type withTime:(NSString *)time withTitle:(NSString *)title withConten:(NSString *)content;

- (NSDictionary *)getParamsDictionary;
- (void)setParamsPropertyByDic:(NSDictionary *)dic;

@end
