//
//  LoginViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LoginViewController.h"
#import "imRms.h"
#import "DatabaseConfig.h"
@interface LoginViewController ()

@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *psw;

@end

@implementation LoginViewController

@synthesize uid;
@synthesize psw;

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
    uid = [imRms userDefaultsRead:@"userid"];
    if(uid == nil)
    {
        uid = @"";
        [imRms userDefaultsWrite:@"userid" withValue:uid];
    }
    NSLog(@"%@",uid);
    self.username.text = uid;
    
    psw = [imRms userDefaultsRead:@"password"];
    if(psw == nil)
    {
        psw = @"";
        [imRms userDefaultsWrite:@"password" withValue:psw];
    }
    NSLog(@"%@",psw);
    self.password.text = psw;
   
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
        NSLog(@"Modal View back : loginViewController to imViewController");
    }];
}

- (IBAction)doneonclick:(id)sender {
    uid = self.username.text;
    [imRms userDefaultsWrite:@"userid" withValue:uid];
    psw = self.password.text;
    [imRms userDefaultsWrite:@"password" withValue:psw];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *mainTabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
    //    registerViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:mainTabBarController animated:YES completion:^{
        NSLog(@"Present TabBar View: mainTabBarController");
    }];
    [DatabaseConfig shareDatabaseConfig].databaseName = [uid stringByAppendingString:@".sqlite"];
}
@end
