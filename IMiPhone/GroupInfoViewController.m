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
    //准备注释监听
    [self registerMessageNotification];

    DPGroup *currGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent];
    [self drawContent: currGroup];
    // Do any additional setup after loading the view.
    //body
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
    // Dispose of any resources that can be recreated.
    //body
}

#pragma mark - Notification
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
    //[super viewDidLoad];
    DPGroup *currGroup = [GroupDataProxy sharedProxy].currentGroup;
    [self drawContent: currGroup];
}

//绘制内容
- (void)drawContent : (DPGroup *) dpGroup {
    if (dpGroup) {
        self.lblGroupId.text = [NSString stringWithFormat:@"群号：%li" , dpGroup.gid];
        self.lblGroupName.text = dpGroup.name;
        self.lblCreatorName.text = [NSString stringWithFormat:@"群主：%@", dpGroup.creator_nick];
        self.lblCTime.text = dpGroup.ctime;
        self.lblMemberNum.text = [NSString stringWithFormat:@"%i",dpGroup.memberNum];
        self.txtvIntro.text = [NSString stringWithFormat:@"%@\n(本地更新时间：%qi)",dpGroup.intro , dpGroup.localUpdateTime];
        self.lblCity.text = dpGroup.creator_city;
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
#pragma mark - 消息监听

#pragma mark - 交互动作

- (IBAction)touchUpBtnBottom:(id)sender {
    //TODO: 点击按钮：进入群聊、加入群
    NSLog(@"点击按钮：进入群聊、加入群");
}
@end
