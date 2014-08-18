//
//  imViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imViewController.h"

@interface imViewController ()

@end

@implementation imViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)regonclick:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"registerViewController"];
//    registerViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registerViewController animated:YES completion:^{
        NSLog(@"Present Modal View: registerViewController");
    }];
}

- (IBAction)loginonclick:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    //    loginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginViewController animated:YES completion:^{
        NSLog(@"Present Modal View: loginViewController");
    }];

}
@end
