//
//  imRms.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imRms : NSObject


+ (bool) userDefaultsWrite:(NSString *)key withValue:(NSString *)value;

+ (NSString*) userDefaultsRead:(NSString*)key;

@end
