//
//  RegisterViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountMessageProxy.h"
#import "IMNWProxyProtocol.h"

@interface RegisterViewController () <IMNWProxyProtocol>

@end

@implementation RegisterViewController

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
    [self.tfPhonenum becomeFirstResponder];
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (IBAction)nextStepSelector:(id)sender {
    if ([imUtil checkPhone:self.tfPhonenum.text]) {
        [[AccountMessageProxy sharedProxy] sendTypeMobcode:self.tfPhonenum.text withCountry:CHINA_CODE];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"regPhoneDoneSegue"]) {
//        RegStep1ViewController *regStep1ViewController = segue.destinationViewController;
//        regStep1ViewController.countryPhone = [NSString stringWithFormat:@"%@ %@", self.lblCountryCode.text, self.tfPhonenum.text ];
//    }
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAccountMobcodeResult:) name:NOTI__ACCOUNT_MOBCODE_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendAccountMobcodeResult:(NSNotification *)notification
{
    if (!notification.object) {
        [self performSegueWithIdentifier:@"regPhoneDoneSegue" sender:self];
    }
}

@end
