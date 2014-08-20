//
//  imUtil.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imUtil.h"

@implementation imUtil

+ (BOOL)checkPassword:(NSString *)password
{
    //BOOL result = NO;
    //NSString *regex = @"//w{6,20}";
    //NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //return [test evaluateWithObject:password];
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[\x21-\x73]{6,20}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", password);
        return YES;
    }
    else
    {
        NSLog(@"%@ isNumbericString: NO", password);
        return NO;
    }
}

@end
