//
//  ActivityMemberDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"

#define DB_PRIMARY_KEY_ACTIVITY_MEMBER_NID @"nid"

@interface DBActivityMember : NSObject

@property (nonatomic) NSInteger nid;//本地顺序id

@property (nonatomic) long long aid;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) long long uid;
@property (nonatomic) NSInteger relation;

@end

@interface ActivityMemberDAO : BaseDAO

+ (ActivityMemberDAO *)sharedDAO;

@end
