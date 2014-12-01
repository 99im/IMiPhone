//
//  ActivityReadyTabController.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityReadyInfoController.h"
#import "ActivityMessageProxy.h"
#import "ActivityDataProxy.h"
#import "ActivityInfoTitleCell.h"
#import "ActivityInfoMoreCell.h"
#import "ActivityInfoDiscussCell.h"
#import "ActivityInfoCreatorCell.h"
#import "ActivityInfoBelongCell.h"
#import "ActivityInfoApplyOkCell.h"
#import "ActivityInfoApplyCell.h"

typedef NS_ENUM(NSInteger, ActivityInfoSection)
{
   ActivityInfoSectionTitle,
   ActivityInfoSectionCreatorOrApplyOk,
   ActivityInfoSectionJoinMembers,
    ActivityInfoSectionTime,
    ActivityInfoSectionMore,
    ActivityInfoSectionDiscuss,
    ActivityInfoSectionNum
};

@interface ActivityReadyInfoController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnJoinOrExit;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnDiscuss;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnFavor;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnReport;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnShare;

@property (nonatomic, retain) DPActivity *dpActivity;

@property (nonatomic) BOOL isTemp;

- (IBAction)barBtnJoinOrExitOnAction:(id)sender;

@end

@implementation ActivityReadyInfoController

static NSString *kActivityInfoTitleCell = @"ActivityInfoTitleCell";
static NSString *kActivityInfoTableApplyOKCell = @"ActivityInfoApplyOkCell";
static NSString *kActivityInfoBelongCell = @"ActivityInfoBelongCell";
static NSString *kActivityInfoApplyCell = @"ActivityInfoApplyCell";
static NSString *kActivityInfoCreatorCell = @"ActivityInfoCreatorCell";
static NSString *kActivityInfoTableMoreCell = @"ActivityInfoMoreCell";
static NSString *kActivityInfoTableDiscussCell = @"ActivityInfoDiscussCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.isTemp = YES;
    long long curAid = [ActivityDataProxy sharedProxy].curAid;
    //TODO:和服务端确认查询活动信息协议正确性
    self.dpActivity =  [[ActivityDataProxy sharedProxy] getActivityWithAid:curAid needRequest:NO];
    
    [self setBtnJoinOrExitText];
    
    [self registerMessageNotification];
    
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];

    
    [super viewWillDisappear:animated];
}

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealNotifyActionJoin:) name:NOTI_H__ACTIVITY_JOIN_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealNotifyActionExit:) name:NOTI_H__ACTIVITY_EXIT_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealNotifyActionJoin:(NSNotification *)notify
{
    self.barBtnJoinOrExit.enabled = YES;
    [self setBtnJoinOrExitText];
}

- (void)dealNotifyActionExit:(NSNotification *)notify
{
    self.barBtnJoinOrExit.enabled = YES;
    [self setBtnJoinOrExitText];
}

#pragma - mark tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case ActivityInfoSectionTitle:
        case ActivityInfoSectionCreatorOrApplyOk:
        case ActivityInfoSectionJoinMembers:
        case ActivityInfoSectionTime:
        case ActivityInfoSectionMore:
            return 1;
        case ActivityInfoSectionDiscuss:
            //TODO:获取本活动的评论的指定数目
            return 0;
        default:
            NSLog(@"ActivityReadyTabController 错误的tableView section:%i",section);
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ActivityInfoSectionNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ActivityInfoSectionTitle) {
        ActivityInfoTitleCell *cellTitle = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoTitleCell forIndexPath:indexPath];
        cellTitle.lblTitle.text = self.dpActivity.title;
        //TODO:活动距离，人气，评论数
//        cellTitle.lblDistance.text = self.dpActivity.
        return cellTitle;
    }
    else if (indexPath.section == ActivityInfoSectionCreatorOrApplyOk) {
        if (self.isTemp == YES) {
            ActivityInfoApplyOkCell *cellApplyOK = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoTableApplyOKCell forIndexPath:indexPath];
            //TODO:显示审核通过的用户头像
//            cellApplyOK.imgViewUser1
            return cellApplyOK;
        }
        else {
            ActivityInfoBelongCell *cellBelong = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoBelongCell forIndexPath:indexPath];
            //TODO:所属聚乐部或者群
//            cellBelong.lblBelong
            //TODO:群等级或者俱乐部等级
//            cellBelong.lblGroupLevel
            return cellBelong;
        }
    }
    else if (indexPath.section == ActivityInfoSectionJoinMembers) {
        ActivityInfoApplyCell *cellJoinMembers = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoApplyCell forIndexPath:indexPath];
        //TODO:根据参加人员显示头像
//        cellJoinMembers.imgViewUser1
        return cellJoinMembers;
    }
    else if (indexPath.section == ActivityInfoSectionTime) {
        ActivityInfoCreatorCell *cellCreator = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoCreatorCell forIndexPath:indexPath];
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:self.dpActivity.createrUid];
        cellCreator.lblCreator.text = [NSLocalizedString(@"Activity.Creator", nil) stringByAppendingString:dpUser.nick ];
        cellCreator.lblCurNum.text =
        [NSString stringWithFormat:@"%@(%li/%li)", NSLocalizedString(@"Activity.CurNum", nil), (long)self.dpActivity.curNum, (long)self.dpActivity.maxNum];
        cellCreator.lblDate.text = [NSLocalizedString(@"Activity.Date", nil) stringByAppendingString:self.dpActivity.beginTime];
//TODO:时间he付费显示
        return cellCreator;
    }
    else if (indexPath.section == ActivityInfoSectionMore) {
        ActivityInfoMoreCell *cellMore = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoTableMoreCell forIndexPath:indexPath];
        cellMore.textView.text = self.dpActivity.detail;
        return cellMore;
    }
    else if (indexPath.section == ActivityInfoSectionDiscuss) {
        ActivityInfoDiscussCell *cellDiscuss = [self.tableView dequeueReusableCellWithIdentifier:kActivityInfoTableDiscussCell forIndexPath:indexPath];
        //TODO:评论的显示
//        cellDiscuss.lblNick = 
        return cellDiscuss;
    }
    else {
        NSLog(@"ActivityReadyTabController cellForRowAtIndexPath 错误的tableView section:%i",indexPath.section);
        return nil;
    }
}

#pragma - mark tableview delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
//    UITableViewCell *cell;
//    NSString *cellIdentify;
    switch (indexPath.section) {
        case ActivityInfoSectionTitle:
//            cellIdentify = kActivityInfoTitleCell;
            height = 65;
            break;
        case ActivityInfoSectionCreatorOrApplyOk:
            if (self.isTemp) {
//                cellIdentify = kActivityInfoTableApplyOKCell;
                height = 100;
            }
            else {
//                cellIdentify = kActivityInfoBelongCell;
                height = 35;

            }
            break;
        case ActivityInfoSectionJoinMembers:
//            cellIdentify = kActivityInfoApplyCell;
            height = 90;
            break;
        case ActivityInfoSectionTime:
//            cellIdentify = kActivityInfoCreatorCell;
            height = 134;
            break;
        case ActivityInfoSectionMore:
//            cellIdentify = kActivityInfoTableMoreCell;
            height = 152;
            break;
        case ActivityInfoSectionDiscuss:
            //TODO:获取本活动的评论条目高度
//             cellIdentify = kActivityInfoTableDiscussCell;
            height = 79;
            break;
        default:
            NSLog(@"ActivityReadyTabController 错误的tableView section:%i",indexPath.section);

    }
//    if (cellIdentify) {
//         cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentify];
//        NSLog(@"活动信息：section:%li cell height:%f", (long)indexPath.section, cell.bounds.size.height);
//        return cell.bounds.size.height;
//    }
//    else {
//        return 0;
//    }
    return height;
}


#pragma - mark other


- (IBAction)barBtnJoinOrExitOnAction:(id)sender
{
    NSLog(@"barBtnJoinOrExitAction");
    NSInteger relation = [ActivityDataProxy sharedProxy].curRelation;

     long long aid = [ActivityDataProxy sharedProxy].curAid;
    if (relation == ACTIVITY_RELATION_CREATOR) {
        
    }
    else if (relation == ACTIVITY_RELATION_MANAGER || relation == ACTIVITY_RELATION_MEMBER) {
        NSLog(@"退出活动 aid:%lli", aid);
        
        [[ActivityMessageProxy sharedProxy] sendHttpExitWithAid:aid];
    }
    else {
        NSLog(@"加入活动 aid:%lli", aid);
        
        [[ActivityMessageProxy sharedProxy] sendHttpJoinWithAid:aid];
    }
   
    self.barBtnJoinOrExit.enabled = NO;
}

- (void)setBtnJoinOrExitText
{
    NSInteger relation = [ActivityDataProxy sharedProxy].curRelation;
    
    if (relation == ACTIVITY_RELATION_CREATOR) {
        self.barBtnJoinOrExit.title = @"";
    }
    else if (relation == ACTIVITY_RELATION_MANAGER || relation == ACTIVITY_RELATION_MEMBER) {
        self.barBtnJoinOrExit.title = NSLocalizedString(@"Activity.Exit", nil);
    }
    else {
        self.barBtnJoinOrExit.title = NSLocalizedString(@"Activity.Join", nil);

    }
}

@end
