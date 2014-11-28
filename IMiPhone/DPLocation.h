//
//  DPLocation.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LBS_TIMEOUT_MINUTES_LOCATION 60  //单位（分钟）   1小时：60   1天: 1440 = 60*24   1周:10080 = 7*24*60

#define LBS_STATUS_SUCCESS 0  //正常
#define LBS_STATUS_SERVICES_NOT_ENABLED 500 //不支持服务

#define LBS_STATUS_DATA_INIT 0          //数据状态：初始化
#define LBS_STATUS_DATA_UPDATING 1      //数据状态：更新进行中
#define LBS_STATUS_DATA_UPDATED 2       //数据状态：更新完毕

@interface DPLocation : NSObject

@property (nonatomic) double longitude; //经度
@property (nonatomic) double latitude; //纬度
@property (nonatomic) double altitude; //海拔

@property (nonatomic) NSInteger dataStatus;     //数据状态, 可取值：LBS_STATUS_DATA_INIT、 LBS_STATUS_DATA_UPDATING、 LBS_STATUS_DATA_UPDATED
@property (nonatomic) long long localUpdateTime; //本地更新时间，格式(yyyyMMddHHmmss)：201411024125959
//@property (nonatomic) long long localExpireTime; //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959

+(DPLocation *)create;

#pragma mark - 状态判断
-(BOOL)isExpired;   //数据是否已过期
-(BOOL)isUpdated;    //是否已更新成功

#pragma mark - 距离计算
-(double)distanceFromLatigude:(double)lat longitude:(double)lon;
-(NSString *)distanceStringFromLatigude:(double)lat longitude:(double)lon;

@end
