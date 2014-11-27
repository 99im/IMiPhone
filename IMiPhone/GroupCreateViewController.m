//
//  GroupCreateViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupCreateViewController.h"

@interface GroupCreateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextView *tvIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) DPGroup *dpGroupCreating;

@end

@implementation GroupCreateViewController

@synthesize dpGroupCreating = _dpGroupCreating;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    _dpGroupCreating = [[GroupDataProxy sharedProxy] getGroupCreating];
    if (_dpGroupCreating.address) {
        self.lblAddress.text = [NSString stringWithFormat:@"地点:%@",_dpGroupCreating.address];
    } else {
        self.lblAddress.text = @"";
    }

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

- (void)didOnGroupCreate:(NSNotification*)notification
{
    if (notification.object) {
        NSString* msg = [((NSError*)notification.object).userInfo objectForKey:NSLocalizedDescriptionKey];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil)
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"群创建成功:%qi", _dpGroupCreating.gid);
            [[GroupDataProxy sharedProxy] setGroupIdCurrent:_dpGroupCreating.gid];
            //[self performSegueWithIdentifier:@"CreatGroup2InfoSegue" sender:self];
            //更新群列表
            //[[GroupDataProxy sharedProxy] getGroupMyList:SEND_HTTP_YES];

            //[[GroupMessageProxy sharedProxy] sendGroupMyList:0 withPageNum:50];
        }];
    }
}


#pragma mark - 交互动作

- (IBAction)cancelGroupCreater:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消建群");
    }];
}

- (IBAction)checkGroupCreate:(id)sender {
    _dpGroupCreating.name = self.tfName.text;
    _dpGroupCreating.intro = self.tvIntro.text;
    //TODO : 输入数据机校验
    if (_dpGroupCreating.name.length > 0) {
        [[GroupMessageProxy sharedProxy] sendGroupCreate:_dpGroupCreating];
    }
}
@end
