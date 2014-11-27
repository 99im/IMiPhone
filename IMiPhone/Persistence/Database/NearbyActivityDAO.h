//
//  NearbyActivityDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"

#define DB_PRIMARY_KEY_BEARBY_ACTIVITY_NID @"nid"

@interface DBNearbyActivity : NSObject

@property (nonatomic) NSInteger nid;

@property (nonatomic) long long aid;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) NSInteger myReleation;

@end

@interface NearbyActivityDAO : BaseDAO

@end
