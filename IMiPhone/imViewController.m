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

@interface imViewController () <IMNWProxyProtocol>

@end

@implementation imViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	// Do any additional setup after loading the view, typically from a nib.
    [self registerMessageNotification];
    
    if (![imUtil checkBlankString:[UserDataProxy sharedProxy].verify] && [UserDataProxy sharedProxy].lastLoginUid != NAN) {
        [[IMNWManager sharedNWManager] initSocketConnect];
        [[IMNWManager sharedNWManager].socketConnect connect:SOCKET_HOST port:SOCKET_PORT];
    }
    else {
        [self performSegueWithIdentifier:@"Start2AccountSegue" sender:self];
    }
    
    [[IMNWManager sharedNWManager] initHttpConnect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketConnectResult:) name:NOTI_SOCKET_CONNECT object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)socketConnectResult:(NSNotification *)notification
{
    if (![notification object]) {
        [self performSegueWithIdentifier:@"Start2MainSegue" sender:self];
    }
}

@end
