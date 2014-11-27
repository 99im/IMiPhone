//
//  MyActivity.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"

#define DB_PRIMARY_KEY_MY_ACTIVITY_NID @"nid"

@interface DBMyActivity : NSObject

@property (nonatomic) NSInteger nid;//本地顺序id

@property (nonatomic) long long aid;
@property (nonatomic, retain) NSString *ctime;//加入时间
@property (nonatomic) NSInteger myReleation;

@end

@interface MyActivityDAO : BaseDAO

+ (MyActivityDAO *)sharedDAO;

@end
