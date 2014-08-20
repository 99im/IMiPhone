//
//  imNWManager.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWSocketConnect.h"

@interface imNWManager : NSObject

@property (nonatomic, retain) imNWSocketConnect *socketConnect;

+ (imNWManager*)sharedNWManager;

- (void)initSocketConnect;

@end
