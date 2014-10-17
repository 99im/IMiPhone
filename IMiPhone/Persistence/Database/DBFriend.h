//
//  DBFriend.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_FRIEND_UID @"uid"

@interface DBFriend : NSObject

@property (nonatomic)         NSInteger uid;
//@property (nonatomic, retain) NSString *beFocusedTime;//被关注的时间
//@property (nonatomic, retain) NSString *focusTime;//关注我的时间
@property (nonatomic, retain) NSString *groups;//分组
@property (nonatomic, retain) NSString *memo;//备注
@property (nonatomic, retain) NSString *byName;//别名


@end
