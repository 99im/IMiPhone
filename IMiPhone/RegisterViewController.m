//
//  RegisterViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegStep1ViewController.h"
#import "AccountMessageProxy.h"

@interface RegisterViewController ()

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
    if ([segue.identifier isEqualToString:@"regPhoneDoneSegue"]) {
        RegStep1ViewController *regStep1ViewController = segue.destinationViewController;
        regStep1ViewController.countryPhone = [NSString stringWithFormat:@"%@ %@", self.lblCountryCode.text, self.tfPhonenum.text ];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"regPhoneDoneSegue"]) {
        if ([imUtil checkPhone:self.tfPhonenum.text]) {
            [[AccountMessageProxy sharedProxy] sendTypeMobcode:self.tfPhonenum.text withCountry:@"+86"];
            return YES;
        }
        else {
            return NO;
        }
    }
    return YES;
}

@end
