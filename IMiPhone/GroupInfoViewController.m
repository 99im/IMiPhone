//
//  GroupInfoViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupInfoViewController.h"

@interface GroupInfoViewController ()

@end

@implementation GroupInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DPGroup *currGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_AUTO];
    [self drawContent: currGroup];
    // Do any additional setup after loading the view.
    //body
}

- (void)viewDidAppear:(BOOL)animated {
    [self registerMessageNotification];
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //body
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - 消息监听
- (void)registerMessageNotification {
   [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveGroupInfo:)
                                                 name:NOTI_H__GROUP_INFO_
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveGroupInfo:(NSNotification *)notification {
    NSLog(@"didReceiveGroupInfo");
    if (notification.object) {
        self.lblGroupName.text = [((NSError *)notification.object).userInfo objectForKey:NSLocalizedDescriptionKey];
        self.btnApply.hidden = YES;
        self.btnGroupChat.hidden = YES;
        self.btnGroupSetting.hidden = YES;
    } else {
        DPGroup *currGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
        [self drawContent: currGroup];
    }

}

//绘制内容
- (void)drawContent : (DPGroup *) dpGroup {
    if (dpGroup) {
        self.lblGroupId.text = [NSString stringWithFormat:@"群号：%lli" , dpGroup.gid];
        self.lblGroupName.text = dpGroup.name;
        self.lblCreatorName.text = [NSString stringWithFormat:@"群主：%@ ", dpGroup.creator_nick];
        self.lblCTime.text = dpGroup.ctime;
        self.lblMemberNum.text = [NSString stringWithFormat:@"%i",dpGroup.memberNum];
        self.tvIntro.text = [NSString stringWithFormat:@"%@\n(本地过期时间：%qi)",dpGroup.intro , dpGroup.localExpireTime];
        self.lblCity.text = dpGroup.creator_city;
        if ([GroupDataProxy isInMyGroups:dpGroup] == YES) {
            self.btnApply.hidden = YES;
            self.btnGroupChat.hidden = NO;
            self.btnGroupSetting.hidden = NO;
        } else {
            self.btnApply.hidden = NO;
            self.btnGroupChat.hidden = YES;
            self.btnGroupSetting.hidden = YES;
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 交互动作

@end
