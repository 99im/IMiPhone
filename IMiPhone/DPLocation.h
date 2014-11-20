//
//  DPLocation.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LBS_TIMEOUT_LOCATION 60  //单位（分钟）   1小时：60   1天: 1440 = 60*24   1周:10080 = 7*24*60

@interface DPLocation : NSObject

@property (nonatomic) double longitude; //经度
@property (nonatomic) double latitude; //纬度
@property (nonatomic) double altitude; //海拔

@property (nonatomic) long long localUpdateTime; //本地更新时间，格式(yyyyMMddHHmmss)：201411024125959
@property (nonatomic) long long localExpireTime; //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959

@end
