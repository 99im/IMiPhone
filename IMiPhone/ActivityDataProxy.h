//
//  ActivityDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPActivity.h"

@interface ActivityDataProxy : NSObject

@property (nonatomic) NSInteger createActivityType;

@property (nonatomic) long long curAid;//当前查看活动id

+ (ActivityDataProxy *)sharedProxy;
- (void)reset;

- (void)updateActivityListWithServerList:(NSArray *)serverList withStart:(NSInteger)start;

- (NSArray *)getActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;

@end
