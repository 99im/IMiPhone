//
//  imViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imViewController.h"
#import "MainTabBarController.h"
#import "UserDataProxy.h"
#import "IMNWManager.h"
#import "IMNWProxyProtocol.h"
#import "IMNWSocketConnect.h"
#import "AccountMessageProxy.h"
#import "FIRMessageProxy.h"

@interface imViewController () <IMNWProxyProtocol>

@property (nonatomic) BOOL hasVerified;

@end

@implementation imViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
        
	// Do any additional setup after loading the view, typically from a nib.
    [[IMNWManager sharedNWManager] initHttpConnect];
    [[IMNWManager sharedNWManager] initSocketConnect];
    self.hasVerified = ![imUtil checkBlankString:[UserDataProxy sharedProxy].verify] && [UserDataProxy sharedProxy].lastLoginUid != LONG_LONG_MAX;
    if (self.hasVerified) {
        [[AccountMessageProxy sharedProxy] sendTypeMyinfo];
    }
#if TARGET_OS_IPHONE
    [[FIRMessageProxy sharedProxy] sendHttpVersion];
#endif
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.hasVerified) {
    }
    else {
        [self performSegueWithIdentifier:@"Start2AccountSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketConnectResult:) name:NOTI_SOCKET_CONNECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendHttpMyinfoResult:) name:NOTI_H__ACCOUNT_MYINFO_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)socketConnectResult:(NSNotification *)notification
{
    //if (!notification.object) {
        [self performSegueWithIdentifier:@"Start2MainSegue" sender:self];
    //}
}

- (void)sendHttpMyinfoResult:(NSNotification *)notification
{
    if (!notification.object) {
        if ([imUtil checkBlankString:[UserDataProxy sharedProxy].user.nick]) {
            [self performSegueWithIdentifier:@"Start2ReginfoSegue" sender:self];
        }
        else {
            [[IMNWManager sharedNWManager].socketConnect connect:SOCKET_HOST port:SOCKET_PORT];
        }
    }
    else
    {
        [UserDataProxy sharedProxy].lastLoginUid = NAN;
        [UserDataProxy sharedProxy].verify = nil;
        [self performSegueWithIdentifier:@"Start2AccountSegue" sender:self];
    }
}

@end
