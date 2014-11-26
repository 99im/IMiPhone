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
#import "ChatDataProxy.h"

@interface UserShowViewController ()

@property (nonatomic, retain) UIAlertView *alertViewFocus;

@end

@implementation UserShowViewController
@synthesize commonUserViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInteger userRelation = [UserDataProxy sharedProxy].showUserInfoRleation;
    [self hideButtonsByReleation:userRelation];
    //根据玩家身份显示个人页
    [self showUserView:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
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

- (void)hideButtonsByReleation:(NSInteger)releation
{
    if (releation == RELATION_STRANGER || releation == RELATION_FAN) {
        [self showStrangerButton:YES];
    }
    else {
        [self showStrangerButton:NO];
    }

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
    
    [ChatDataProxy sharedProxy].chatViewType = ChatViewTypeP2P;
    [ChatDataProxy sharedProxy].chatToUid = [UserDataProxy sharedProxy].showUserInfoUid;
    [self performSegueWithIdentifier:@"Result2ChatSegue" sender:self];
}

- (IBAction)btnMoreTouchUpInside:(id)sender {
   UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Remark", nil), NSLocalizedString(@"Focus.Cancel", nil), NSLocalizedString(@"Black.List.Report", nil), nil];
    [actionSheet showInView:self.view];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     DPUser *userInfo = [[UserDataProxy sharedProxy] getUserByUid:[UserDataProxy sharedProxy].showUserInfoUid];
    if (alertView == self.alertViewFocus) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }
        else if(buttonIndex == 1) {
            NSLog(@"OK");
            [[FriendMessageProxy sharedProxy] sendTypeFocusAdd:[NSNumber numberWithLongLong:userInfo.uid]];
        }
        self.alertViewFocus = nil;
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DPUser *userInfo = [[UserDataProxy sharedProxy] getUserByUid:[UserDataProxy sharedProxy].showUserInfoUid];
    if (buttonIndex == 0) {
         NSLog(@"remark");
    }
    else if(buttonIndex == 1) {
        NSLog(@"Focus Cancel");
        [[FriendMessageProxy sharedProxy] sendTypeFocusCancel:[NSNumber numberWithLongLong:userInfo.uid]];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFocusAddResult:) name:NOTI_H__FRIEND_FOCUS_ADD_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFocusCancelResult:) name:NOTI_H__FRIEND_FOCUS_CANCEL_ object:nil];
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
    
    NSInteger userRelation = [UserDataProxy sharedProxy].showUserInfoRleation;
    [self hideButtonsByReleation:userRelation];
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
    
    NSInteger userRelation = [UserDataProxy sharedProxy].showUserInfoRleation;
    [self hideButtonsByReleation:userRelation];
}

- (void)showUserView:(NSInteger)identity{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.commonUserViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CommonUserViewController"];
    self.commonUserViewController.view.frame = CGRectMake(0.0f, 0.0f, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    [self.viewContent addSubview:self.commonUserViewController.view];
    [self addChildViewController:self.commonUserViewController];
    DPUser *userInfo = [[UserDataProxy sharedProxy] getUserByUid:[UserDataProxy sharedProxy].showUserInfoUid];
    [self.commonUserViewController.lblUserNick setText:userInfo.nick];
    [self.commonUserViewController.lblUserOid setText:userInfo.oid];
}


@end
