//
//  DBActivity.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_ACTIVITY_AID @"aid"

@interface DBActivity : NSObject

@property (nonatomic) NSInteger orderid;//序号

@property (nonatomic) long long aid;//活动id
@property (nonatomic, retain) NSString *title;//活动标题
@property (nonatomic, retain) NSString *detail;
@property (nonatomic) NSInteger type;
@property (nonatomic) long long typeId;
@property (nonatomic) NSInteger signerLimit;
@property (nonatomic) NSInteger payType;
@property (nonatomic) NSInteger ladyFree;
//location
@property (nonatomic, retain) NSString *lon;//经度
@property (nonatomic, retain) NSString *lat;//纬度
@property (nonatomic, retain) NSString *alt;//海拔
//@property (nonatomic, retain) NSString *geohash;
@property (nonatomic) NSInteger curNum;
@property (nonatomic) long long createrUid;
@property (nonatomic, retain) NSString *ctime;

@end
