//
//  LoginViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountMessageProxy.h"
#import "IMNWProxyProtocol.h"

@interface LoginViewController () <IMNWProxyProtocol>

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.tfUsername.text = uid;
    //    self.tfPassword.text = psw;
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self registerMessageNotification];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)doneSelector:(id)sender {
    if (self.tfUsername.text.length > 0 && self.tfPassword.text.length > 0) {
        [[AccountMessageProxy sharedProxy] sendTypeLogin:self.tfUsername.text fromCountry:@"" withPwd:self.tfPassword.text];
    }
    [self performSegueWithIdentifier:@"loginDoneSegue" sender:self];
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAccountLogin:) name:NOTI__ACCOUNT_LOGIN_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendAccountLogin:(NSNotification *)notification
{
    if (![notification object]) {
        
    }
}

@end
