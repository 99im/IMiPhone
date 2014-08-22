//
//  imViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imViewController.h"
#import "imNWManager.h"

@interface imViewController ()

@end

@implementation imViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Socket测试
    //[[imNWManager sharedNWManager] initSocketConnect];
    //[[imNWManager sharedNWManager].socketConnect connect:@"124.225.214.126" port:8019];
    
    //Http测试
    imNWMessage *message = [[imNWMessage alloc] init];
    message.host = @"gamify.tianya.cn";
    srand((unsigned)time(0));
    message.path = [NSString stringWithFormat:@"/app/bobing/server/?&r=%i",rand()];
    message.connect = CONNECT_HTTP;
    [[imNWManager sharedNWManager] initHttpConnect];
    [[imNWManager sharedNWManager] sendMessage:message];
    
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
