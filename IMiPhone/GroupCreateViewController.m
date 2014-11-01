//
//  GroupCreateViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupCreateViewController.h"

@interface GroupCreateViewController ()

@end

@implementation GroupCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerMessageNotification];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
    // Dispose of any resources that can be recreated.
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Notification
- (void)registerMessageNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didOnGroupCreate:)
                                                 name:NOTI_H__GROUP_CREATE_
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didOnGroupCreate:(NSNotification *)notification {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"群创建成功！");
        //更新群列表
        [[GroupMessageProxy sharedProxy] sendGroupMyList:0 withPageNum:5];
    }];
}


#pragma mark - 交互动作

- (IBAction)cancelGroupCreater:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消建群");
    }];
}

- (IBAction)checkGroupCreate:(id)sender {
    NSString *name = self.tfName.text;
    NSString *intro = self.tvIntro.text;
    //TODO : 输入数据机校验
    if (name.length > 0) {
        [[GroupMessageProxy sharedProxy] sendGroupCreate:name withIntro:intro];
    }
}
@end
