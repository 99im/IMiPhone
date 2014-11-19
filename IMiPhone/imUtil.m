//
//  imUtil.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imUtil.h"
#import "NSNumber+IMNWError.h"

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
    NSInteger length = [self countStringLength:nick];
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

+ (void)clearFirstResponder
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    if (firstResponder) {
        [firstResponder resignFirstResponder];
    }
}

+ (void)alertViewMessage:(NSString *)msg disappearAfter:(NSTimeInterval)ti
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    [self performSelector:@selector(dimissAlert:) withObject:alertView afterDelay:2.0];
}

+ (void) dimissAlert:(UIAlertView *)alert {
    if(alert)     {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}

#pragma mark - 获取时间相关

+ (long long)longLongNowTime:(NSString *)dateFormat
{
    NSDate *senddate = [NSDate date];
    [senddate timeIntervalSince1970];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    if (dateFormat && [dateFormat length] > 0) {
        [dateformatter setDateFormat:dateFormat];
    }
    else {
        [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    }

    NSString *locationString = [dateformatter stringFromDate:senddate];
    long long nowTime = [locationString longLongValue];
    return nowTime;
}

+ (long long)nowTime
{
    return [imUtil longLongNowTime:@"yyyyMMddHHmmss"];
}

+ (long long)getExpireTimeWithMinutes:(NSInteger)minutes{
    long long expireTime = [imUtil nowTime];
    if (minutes > 1) {
        expireTime = expireTime + minutes * 60;
    } else {
        expireTime = expireTime + 60;
    }
    return expireTime;
}

#pragma mark camera utility

+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
@end
