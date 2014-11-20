//
//  DPPlacemark.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPPlacemark : NSObject

@property (nonatomic) double longitude; //经度
@property (nonatomic) double latitude; //纬度
@property (nonatomic) double altitude; //海拔

@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *subLocality;
@property (nonatomic, retain) NSString *thoroughfare;
@property (nonatomic, retain) NSString *subThoroughfare;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *addressLines;

@property (nonatomic) long long localUpdateTime; //本地更新时间，格式(yyyyMMddHHmmss)：201411024125959
@property (nonatomic) long long localExpireTime; //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959

@end
