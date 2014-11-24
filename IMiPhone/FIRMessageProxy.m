//
//  FIRMessageProxy.m
//  IMiPhone
//
//  Created by yinowl on 14/11/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FIRMessageProxy.h"

@interface FIRMessageProxy () <UIAlertViewDelegate>

@end

@implementation FIRMessageProxy

static FIRMessageProxy *sharedFIRMessageProxy = nil;

+ (FIRMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFIRMessageProxy = [[self alloc] init];
    });
    return sharedFIRMessageProxy;
}

- (void)sendHttpVersion
{
    IMNWMessage *message = [IMNWMessage createForHttpUseURL:@"http://fir.im/api/v2/app/version/cn.taiqiu.IMiPhone" withParams:nil withMethod:METHOD_GET];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:@"code"] intValue];
            if (errorcode == 0) {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
                
                NSString *version = [json objectForKey:@"version"];
                NSString *changelog = [json objectForKey:@"changelog"];
                
                if (![app_Version isEqualToString:version]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本" message:changelog delegate:self cancelButtonTitle:@"升级" otherButtonTitles:nil];
                    [alertView show];
                }
            }
            else {
                NSLog(@"%@", [json objectForKey:@"message"]);
            }
        }
    }];
}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *url = @"http://fir.im/hi8";//@"itms-services://?action=download-manifest&url=https%3A%2F%2Ffir.im%2Fapi%2Fv2%2Fapp%2Finstall%2F546dba039869418b29000b2a";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
