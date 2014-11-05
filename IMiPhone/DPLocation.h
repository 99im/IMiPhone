//
//  DPLocation.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPLocation : NSObject

@property(nonatomic) double lon;    //经度
@property(nonatomic) double lat;    //纬度
@property(nonatomic) double alt;    //海拔

@property(nonatomic, retain) NSString *state;
@property(nonatomic, retain) NSString *city;
@property(nonatomic, retain) NSString *street;
@property(nonatomic, retain) NSString *zip;

@property (nonatomic) long long localExpireTime;  //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959

@end
