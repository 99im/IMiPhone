//
//  RegisterViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegisterViewController.h"
#import "imUtil.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)backonclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Modal View back : registerViewController to imViewController");
    }];
}

- (IBAction)doneonclick:(id)sender {
    NSString *password = self.tfPassword.text;
    if ([imUtil checkPassword:password]) {
        NSLog(@"invalid password");
    }
}

- (IBAction)codeonclick:(id)sender {
}
@end
