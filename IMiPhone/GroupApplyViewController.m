//
//  GroupApplyViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupApplyViewController.h"

@interface GroupApplyViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tvMsg;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSubmit;

- (IBAction)submitGroupApply:(id)sender;
//- (IBAction)cancelGroupApply:(id)sender;

@end

@implementation GroupApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
    self.navigationController.title = [NSString stringWithFormat:@"申请加入：%@", dpGroup.name];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
#pragma mark - IBAction

- (IBAction)submitGroupApply:(id)sender
{
    self.btnSubmit.enabled = NO; //避免频繁提交
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
    if ([dpGroup isGroupApplicant]) { //已申请过
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请加群"
                                                            message:@"你已提交过申请，请耐心等待管理员审核..."
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([dpGroup isGroupMember]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请加群"
                                                            message:@"你已是群成员了"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        dpGroup.myRelation = GROUP_RELATION_APPLICANT;
        [[GroupMessageProxy sharedProxy] sendGroupApply:dpGroup.gid msg:self.tvMsg.text];
    }
}

//- (IBAction)cancelGroupApply:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"取消申请");
//    }];
//}
#pragma mark - Notification
- (void)registerMessageNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDidGroupApply:)
                                                 name:NOTI_H__GROUP_APPLY_
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveDidGroupApply:(NSNotification *)notification {
    //TODO：判断申请是否发送成功
    UIAlertView *alertView;
    if (notification.object) {
        NSError *error = notification.object;
        NSInteger errorCode = error.code;
        NSString *message;
        if (errorCode == GROUP_ERR_CODE_applied) {
            message = @"你已提交过申请，请耐心等待管理员审核...";
            DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
            dpGroup.myRelation = GROUP_RELATION_APPLICANT;
        } else {
            message = error.description;
        }
        alertView = [[UIAlertView alloc] initWithTitle:@"申请加群"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:true];
    } else {
        //NSLog(@"申请成功");
        alertView = [[UIAlertView alloc] initWithTitle:@"申请加群"
                                               message:@"申请已提交，请耐心等待管理员审核..."
                                              delegate:self
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController popViewControllerAnimated:true];
        //[self performSegueWithIdentifier:@"groupApply2GroupInfo" sender:self];
    }

}


@end
