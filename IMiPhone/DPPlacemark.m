//
//  DPPlacemark.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPPlacemark.h"

@implementation DPPlacemark

@synthesize longitude;
@synthesize latitude;
@synthesize altitude;

@synthesize name;
@synthesize thoroughfare;
@synthesize subThoroughfare;
@synthesize locality;
@synthesize subLocality;
@synthesize administrativeArea;
@synthesize subAdministrativeArea;
@synthesize postalCode;
@synthesize ISOcountryCode;
@synthesize country;
@synthesize inlandWater;
@synthesize ocean;

@synthesize localUpdateTime;
@synthesize localExpireTime;


-(NSString *)getAddress
{
    NSString *address = @"";
    if (self.locality) {
        address = [address stringByAppendingString:self.locality];
    }
    if (self.thoroughfare) {
        address = [address stringByAppendingString:self.thoroughfare];
    }
    if (self.subThoroughfare) {
        address = [address stringByAppendingString:self.subThoroughfare];
    }
    return address;
}

-(NSString *)getFullAdress
{
    NSString *address = @"";
    if (self.administrativeArea) {
        address = [address stringByAppendingString:self.administrativeArea];
    }
    if (self.subAdministrativeArea) {
        address = [address stringByAppendingString:self.subAdministrativeArea];
    }
    address = [address stringByAppendingString:[self getAddress]];
    return address;
}
@end
