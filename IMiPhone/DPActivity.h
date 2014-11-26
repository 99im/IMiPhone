//
//  DPActivity.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPActivity : NSObject

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
@property (nonatomic, retain) NSString *ctime;//创建时间
@property (nonatomic) NSInteger myreleation;

@property (nonatomic) NSInteger maxNum;//最大人员数量
@property (nonatomic, retain) NSString *beginTime;
@property (nonatomic, retain) NSString *endTime;

@property (nonatomic, retain) NSArray *members;//成员

@end

