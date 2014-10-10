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
#import "UserMessageProxy.h"

@interface UserShowViewController ()

@property (nonatomic, retain) UIAlertView * alertView;

@end

@implementation UserShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *userInfo = [UserDataProxy sharedProxy].arrSearchUserResult[0];
    [self.lblNickname setText:[userInfo objectForKey:KEYP__USER_SEARCH__LIST_UINFO_NICK]];
    [self.lblOid setText:[userInfo objectForKey:KEYP__USER_SEARCH__LIST_UINFO_OID]];
    
    NSInteger userRelation = [[userInfo valueForKey:KEYP__USER_SEARCH__LIST_UINFO_RELATION] integerValue];
    if (userRelation == RELATION_STRANGER || userRelation == RELATION_FAN) {
        [self showStrangerButton:YES];
    }
    else {
        [self showStrangerButton:NO];
    }
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

- (void)showStrangerButton:(BOOL)value
{
    self.btnChat.hidden = value;
    self.btnBlackList.hidden = !value;
    self.btnFocus.hidden = !value;
    self.btnMessage.hidden = !value;
}

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
        [[FriendMessageProxy sharedProxy] sendTypeFocusAdd:[userInfo objectForKey:KEYP__USER_SEARCH__LIST_UINFO_UID]];
    }
    self.alertView = nil;
}

@end
