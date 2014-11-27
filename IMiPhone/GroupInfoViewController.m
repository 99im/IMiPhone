//
//  GroupInfoViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupInfoViewController.h"

@interface GroupInfoViewController ()

@property (weak, nonatomic) UIBarButtonItem *btnMoreCache;

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupId;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblCTime;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatorName;

@property (weak, nonatomic) IBOutlet UITextView *tvIntro;

@property (weak, nonatomic) IBOutlet UIButton *btnMain;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMore;

- (IBAction)btnMoreTouchUp:(id)sender;
- (IBAction)btnMainTouchUp:(id)sender;

@end

@implementation GroupInfoViewController

@synthesize btnMoreCache = _btnMoreCache;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.btnMain.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self registerMessageNotification];
    [super viewDidAppear:animated];

    self.btnMain.hidden = YES;

    DPGroup *currGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_AUTO];
    [self drawContent:currGroup];
    [self registerMessageNotification];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
    // Dispose of any resources that can be recreated.
    // body
}

- (void)viewWillDisappear:(BOOL)animated
{
    //[self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - 消息监听
- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveGroupInfo:)
                                                 name:NOTI_H__GROUP_INFO_
                                               object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveGroupInfo:(NSNotification *)notification
{
    NSLog(@"didReceiveGroupInfo");
    if (notification.object) {
        self.lblGroupName.text = [((NSError *)notification.object).userInfo objectForKey:NSLocalizedDescriptionKey];
        [self drawContent:nil];
    }
    else {
        DPGroup *currGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
        [self drawContent:currGroup];
    }
}

//绘制内容
- (void)drawContent:(DPGroup *)dpGroup
{
    if (dpGroup) {
        self.lblGroupId.text = [NSString stringWithFormat:@"群号：%qi", dpGroup.gid];
        self.lblGroupName.text = dpGroup.name;
        self.lblCreatorName.text = [NSString stringWithFormat:@"群主：%@  (%qi)", dpGroup.creator_nick, dpGroup.creator_oid];
        self.lblCity.text = [NSString stringWithFormat:@"%@", dpGroup.address];
        self.lblCTime.text = dpGroup.ctime;
        self.lblMemberNum.text = [NSString stringWithFormat:@"成员：%li 人", (long)dpGroup.memberNum];
        self.tvIntro.text =
            [NSString stringWithFormat:@"%@\n经纬(%f, %f) \n过期(%qi)", dpGroup.intro, dpGroup.longitude, dpGroup.latitude, dpGroup.localExpireTime];
        self.btnMore.enabled = NO;
        if ([dpGroup isGroupMember]) {
            [self.btnMain setTitle:@"进入聊天" forState:UIControlStateNormal];
            self.btnMain.hidden = NO;
            self.btnMore.enabled = YES;
        } else if([dpGroup isGroupApplicant]) {
            [self.btnMain setTitle:@"你已提交申请" forState:UIControlStateNormal];
            self.btnMain.hidden = NO;
            self.btnMain.enabled = NO;
        } else if([dpGroup canGroupApply]) {
            [self.btnMain setTitle:@"申请加入" forState:UIControlStateNormal];
            self.btnMain.hidden = NO;
        } else {
            self.btnMain.hidden = YES;
        }
    } else {
        self.btnMain.hidden = YES;
        self.btnMore.enabled = NO;
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

- (IBAction)btnMoreTouchUp:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"群组设置", @"查看成员", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)btnMainTouchUp:(id)sender {
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
    if ([dpGroup isGroupMember]) {
        [self performSegueWithIdentifier:@"groupInfo2GroupChat" sender:self];
    //} else if([dpGroup isGroupOK]){ //群已通过审核
    } else if([dpGroup canGroupApply]){//开始提交申请
        [self performSegueWithIdentifier:@"groupInfo2GroupApply" sender:self];
        //NSLog(@"开始提交申请");
    } else {

    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //NSLog(@"群组设置");
        [self performSegueWithIdentifier:@"groupInfo2GroupSetting" sender:self];
    }
    else if (buttonIndex == 1) {
        NSLog(@"查看成员");
    }
}
@end
