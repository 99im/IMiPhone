//
//  imAppDelegate.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imAppDelegate.h"
#import "IMNWManager.h"

@implementation imAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //注册推送通知功能
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    
    //判断程序是不是由推送服务完成的
    if (launchOptions) {
        NSDictionary *pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送通知"
                                                           message:@"这是通过推送窗口启动的程序，你可以在这里处理推送内容"
                                                          delegate:nil
                                                 cancelButtonTitle:@"知道了"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[IMNWManager sharedNWManager].socketConnect.socket disconnect];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[IMNWManager sharedNWManager].socketConnect disconnect];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Remote Notification regisger success, deviceToken: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Remote Notification regisger fail, %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 处理推送消息
    NSLog(@"Remote Notification received: %@", userInfo);
    // 把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"处理推送内容",nil];
        [alert show];
    }
}

@end
