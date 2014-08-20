//
//  imNWSocketConnect.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface imNWSocketConnect : NSObject

@property (nonatomic, retain) AsyncSocket *socket;

- (void)connect:(NSString *)hostIP port:(int)hostPort;

@end
