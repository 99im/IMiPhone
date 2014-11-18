//
//  DPFocusUser.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPFocusUser : NSObject

@property (nonatomic) long long focusUid;//用户id
@property (nonatomic, retain) NSString *byName;//别名
@property (nonatomic, retain) NSString *memo;//备注
@property (nonatomic, retain) NSString *groups;// 分组信息
@property (nonatomic) NSInteger relation;// 关系
@property (nonatomic) NSInteger isFriends;// 是否是好友

@end
