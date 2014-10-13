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

@property (nonatomic, retain) UIAlertView *alertViewFocus;

@end

@implementation UserShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *userInfo = [UserDataProxy sharedProxy].showUserInfo;
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
    self.btnMore.hidden = value;
}

#pragma mark - reactive the buttons event
- (IBAction)focusTouchUpInside:(id)sender {

    if (self.alertViewFocus == nil) {
        self.alertViewFocus = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Tip", nil) message:NSLocalizedString(@"Alert.Tip.Focus", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [self.alertViewFocus show];
    }
}

- (IBAction)btnBlackListTouchUpInside:(id)sender {
}

- (IBAction)btnMessageTouchUpInside:(id)sender {
}

- (IBAction)btnChatTouchUpInside:(id)sender {
}

- (IBAction)btnMoreTouchUpInside:(id)sender {
   UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Remark", nil), NSLocalizedString(@"Focus.Cancel", nil), NSLocalizedString(@"Black.List.Report", nil), nil];
    [actionSheet showInView:self.view];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     NSDictionary *userInfo = [UserDataProxy sharedProxy].showUserInfo;
    if (alertView == self.alertViewFocus) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }
        else if(buttonIndex == 1) {
            NSLog(@"OK");
            [[FriendMessageProxy sharedProxy] sendTypeFocusAdd:[userInfo objectForKey:KEYP__USER_SEARCH__LIST_UINFO_UID]];
        }
        self.alertViewFocus = nil;
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *userInfo = [UserDataProxy sharedProxy].showUserInfo;
    if (buttonIndex == 0) {
         NSLog(@"remark");
    }
    else if(buttonIndex == 1) {
        NSLog(@"Focus Cancel");
        [[FriendMessageProxy sharedProxy] sendTypeFocusCancel:[userInfo objectForKey:KEYP__USER_SEARCH__LIST_UINFO_UID]];
    }
    else if (buttonIndex == 2) {
        NSLog(@"Black list and report");
    }
    else if (buttonIndex == 3) {
        NSLog(@"cancel");
    }
}

#pragma mark - IMNWProxyProtocol Method
- (void)registerMessageNotification
{
    //监听搜索用户结果的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFocusAddResult:) name:NOTI__FRIEND_FOCUS_ADD_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFocusCancelResult:) name:NOTI__FRIEND_FOCUS_CANCEL_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - show oprate result
- (void)showFocusAddResult:(NSNotification *)notification
{
    NSString *strTip;
    if (notification.object) {
        //添加失败
        strTip = [((NSError *)notification.object).userInfo objectForKey:NSLocalizedDescriptionKey];
    }
    else{
        strTip = NSLocalizedString(@"Alert.Tip.Focus.Success", nil);
    }
    [imUtil alertViewMessage:strTip disappearAfter:2.0f];
}

- (void)showFocusCancelResult:(NSNotification *)notification
{
    NSString *strTip;
    if (notification.object) {
        //取消失败
        strTip = [((NSError *)notification.object).userInfo objectForKey:NSLocalizedDescriptionKey];
    }
    else{
        strTip = NSLocalizedString(@"Alert.Tip.Focus.Cancel.Success", nil);
    }
    [imUtil alertViewMessage:strTip disappearAfter:2.0f];
}

@end
