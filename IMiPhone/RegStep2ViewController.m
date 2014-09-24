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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTypeMyinfoResult:) name:NOTI__ACCOUNT_MYINFO_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendTypeMyinfoResult:(NSNotification *)notification
{
    if (![notification object]) {
        [self performSegueWithIdentifier:@"regStep2DoneSegue" sender:self];
    }
}

@end
