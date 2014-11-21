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

// address dictionary properties
@property (nonatomic, copy) NSString *name; // eg. Apple Inc.
@property (nonatomic, copy) NSString *thoroughfare; // street address, eg. 1 Infinite Loop
@property (nonatomic, copy) NSString *subThoroughfare; // eg. 1
@property (nonatomic, copy) NSString *locality; // city, eg. Cupertino
@property (nonatomic, copy) NSString *subLocality; // neighborhood, common name, eg. Mission District
@property (nonatomic, copy) NSString *administrativeArea; // state, eg. CA
@property (nonatomic, copy) NSString *subAdministrativeArea; // county, eg. Santa Clara
@property (nonatomic, copy) NSString *postalCode; // zip code, eg. 95014
@property (nonatomic, copy) NSString *ISOcountryCode; // eg. US
@property (nonatomic, copy) NSString *country; // eg. United States
@property (nonatomic, copy) NSString *inlandWater; // eg. Lake Tahoe
@property (nonatomic, copy) NSString *ocean; // eg. Pacific Ocean
//@property (nonatomic, readonly, copy) NSArray *areasOfInterest; // eg. Golden Gate Park

@property (nonatomic) long long localUpdateTime; //本地更新时间，格式(yyyyMMddHHmmss)：201411024125959
@property (nonatomic) long long localExpireTime; //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959

@end
