//
//  imViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imViewController.h"
#import "imNWManager.h"
#import "imRms.h"

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
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSLog(@"Http connect response string: %@", responseString);
        NSLog(@"Http connect response data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)touchLogin:(id)sender {
//     NSLog(@"%@",[imRms userDefaultsRead:@"userid"]);
//}
- (IBAction)registerclick:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];//
//    //    registerViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registerViewController animated:YES completion:^{
        NSLog(@"Present Modal View: registerViewController");
    }];
    
    
}

- (IBAction)loginonclick:(id)sender {
    
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //    loginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginViewController animated:YES completion:^{
        NSLog(@"Present Modal View: loginViewController");
    }];


}
@end
