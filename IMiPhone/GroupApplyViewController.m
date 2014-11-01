//
//  GroupApplyViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupApplyViewController.h"

@interface GroupApplyViewController ()

@end

@implementation GroupApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
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

- (IBAction)checkGroupApply:(id)sender {
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent];
    if (dpGroup && dpGroup.gid >0 ) {
        NSString *gid = [NSString stringWithFormat:@"%li",dpGroup.gid];
        NSString *msg = self.tvMsg.text;
        NSLog(@"开始提交申请:%@ %@", gid , msg);
        [[GroupMessageProxy sharedProxy] sendGroupApply:gid msg:msg];
    }
}

- (IBAction)cancelGroupApply:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消申请");
    }];
}
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
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"申请成功");
    }];
}


@end