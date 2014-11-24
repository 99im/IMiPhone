//
//  RegStep2ViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegStep2ViewController.h"
#import "AccountMessageProxy.h"
#import "IMNWProxyProtocol.h"
#import "UserDataProxy.h"

@interface RegStep2ViewController () <UITextFieldDelegate, IMNWProxyProtocol>

@end

@implementation RegStep2ViewController

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
    [self.tfPassword becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)doneSelector:(id)sender {
    if ([imUtil checkPassword:self.tfPassword.text]) {
        [[AccountMessageProxy sharedProxy] sendTypeRegister:self.tfPassword.text];
    }
}

#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([imUtil checkPassword:self.tfPassword.text]) {
        [[AccountMessageProxy sharedProxy] sendTypeRegister:self.tfPassword.text];
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendHttpRegisterResult:) name:NOTI_H__ACCOUNT_REGISTER_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendHttpLoginResult:) name:NOTI_H__ACCOUNT_LOGIN_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendHttpRegisterResult:(NSNotification *)notification
{
    if (!notification.object) {
        [[AccountMessageProxy sharedProxy] sendHttpLogin:[UserDataProxy sharedProxy].mobile fromCountry:[UserDataProxy sharedProxy].mobCountry withPwd:self.tfPassword.text];
    }
}

- (void)sendHttpLogin:(NSNotification *)notification
{
    if (!notification.object) {
        [self performSegueWithIdentifier:@"regStep2DoneSegue" sender:self];
    }
}

@end
