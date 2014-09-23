//
//  NSNumber+IMNWError.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NSNumber+IMNWError.h"

@implementation NSNumber (IMNWError)

- (NSString *)errorMessage
{
    NSString *sError = @"";
    
    switch (self.integerValue) {
        case 10000:
            sError = @"";
            break;
            
        default:
            sError = @"尼玛！未知的错误！！！";
            break;
    }
    
    return sError;
}

@end
