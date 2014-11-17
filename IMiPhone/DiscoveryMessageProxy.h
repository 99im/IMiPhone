//
//  DiscoveryMessageProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "LocationDataProxy.h"

@interface DiscoveryMessageProxy : IMNWProxy

+ (DiscoveryMessageProxy *)sharedProxy;

- (void)sendDiscoveryReportGEO:(DPLocation *)dpLocation;
- (void)sendDiscoveryNearbyList:(double)lat longitude:(double)lon altitude:(double)alt;
@end
