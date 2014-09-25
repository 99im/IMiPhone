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
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[\x21-\x73]{6,20}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        NSLog(@"check password error: %@", password);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"Alert.Password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
}

+ (BOOL)checkPhone:(NSString *)phone
{
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]{11}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularExpression numberOfMatchesInString:phone options:NSMatchingReportProgress range:NSMakeRange(0, phone.length)];
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"Alert.Phone", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
        NSLog(@"check phone error: %@", phone);
        return NO;
    }
}

+ (BOOL)checkPoint:(CGPoint)point inRectangle:(CGRect)rect
{
    if (point.x < rect.origin.x || point.x > rect.origin.x + rect.size.width) {
        return NO;
    }
    if (point.y < rect.origin.y || point.y > rect.origin.y + rect.size.height) {
        return NO;
    }
    return YES;
}

+ (BOOL)checkBlankString:(NSString *)content
{
    if (content == nil || content == NULL) {
        return YES;
    }
    if ([content isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkNick:(NSString *)nick
{
    int length = [self countStringLength:nick];
    if (length <= NICK_LENGTH_MAX) {
        return YES;
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"Alert.Nick", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
        NSLog(@"check phone error: %@", nick);
        return NO;
    }
}

+ (NSInteger)countStringLength:(NSString *)content
{
    NSInteger conLength = 0;
    char *pContent = (char *)[content cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [content lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*pContent) {
            pContent++;
            conLength++;
        }
        else {
            pContent++;
        }
    }
    return conLength;
}

@end
