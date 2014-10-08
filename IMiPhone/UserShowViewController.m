//
//  UserShowViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-24.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserShowViewController.h"
#import "UserDataProxy.h"
#import "FriendDataProxy.h"
#import "FriendMessageProxy.h"

@interface UserShowViewController ()

@property (nonatomic, retain) UIAlertView * alertView;

@end

@implementation UserShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *userInfo = [UserDataProxy sharedProxy].arrSearchUserResult[0];
    [self.lblNickname setText:[userInfo valueForKey:KEY_USER_SERCH_USER_INFO_NICK]];
    [self.lblOid setText:[userInfo valueForKey:KEY_USER_SERCH_USER_INFO_OID]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)focusTouchUpInside:(id)sender {
    
    if (self.alertView == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Tip", nil) message:NSLocalizedString(@"Alert.Tip.Focus", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"cancel");
    }
    else if(buttonIndex == 1){
        NSLog(@"OK");
        NSDictionary *userInfo = [UserDataProxy sharedProxy].arrSearchUserResult[0];
        [[FriendMessageProxy sharedProxy] sendTypeFocusAdd:[userInfo valueForKey:KEY_USER_SERCH_USER_INFO_UID]];
    }
    self.alertView = nil;
}

@end
