//
//  ActivityReadyTabController.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityReadyTabController.h"
#import "ActivityMessageProxy.h"
#import "ActivityDataProxy.h"

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

@interface ActivityReadyTabController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BOOL isTemp;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnJoinOrExit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnDiscuss;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnFavor;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnReport;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnShare;

- (IBAction)barBtnJoinOrExitAction:(id)sender;

@end

@implementation ActivityReadyTabController

static NSString *ActivityInfoTitleCell = @"ActivityInfoTableTitleCell";
static NSString *ActivityInfoTableApplyOKCell = @"ActivityInfoTableApplyOKCell";
static NSString *ActivityInfoTableCreatorCell = @"ActivityInfoTableCreatorCell";
static NSString *ActivityInfoTableJoinMembersCell = @"ActivityInfoTableJoinMembersCell";
static NSString *ActivityInfoTableTimeCell = @"ActivityInfoTableTimeCell";
static NSString *ActivityInfoTableMoreCell = @"ActivityInfoTableMoreCell";
static NSString *ActivityInfoTableDiscussCell = @"ActivityInfoTableDiscussCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.isTemp = YES;
}

- (void)viewWillDisappear:(BOOL)annimated
{
    
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
        UITableViewCell *cellTitle = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTitleCell forIndexPath:indexPath];
        return cellTitle;
    }
    else if (indexPath.section == ActivityInfoSectionCreatorOrApplyOk) {
        if (self.isTemp == YES) {
            UITableViewCell *cellApplyOK = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableApplyOKCell forIndexPath:indexPath];
            return cellApplyOK;
        }
        else {
            UITableViewCell *cellCreator = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableCreatorCell forIndexPath:indexPath];
            return cellCreator;
        }
    }
    else if (indexPath.section == ActivityInfoSectionJoinMembers) {
        UITableViewCell *cellJoinMembers = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableJoinMembersCell forIndexPath:indexPath];
        return cellJoinMembers;
    }
    else if (indexPath.section == ActivityInfoSectionTime) {
        UITableViewCell *cellTime = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableTimeCell forIndexPath:indexPath];
        return cellTime;
    }
    else if (indexPath.section == ActivityInfoSectionMore) {
        UITableViewCell *cellMore = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableMoreCell forIndexPath:indexPath];
        return cellMore;
    }
    else if (indexPath.section == ActivityInfoSectionDiscuss) {
        UITableViewCell *cellDiscuss = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoTableDiscussCell forIndexPath:indexPath];
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
    switch (indexPath.section) {
        case ActivityInfoSectionTitle:
        case ActivityInfoSectionCreatorOrApplyOk:
        case ActivityInfoSectionJoinMembers:
            return 44;
        case ActivityInfoSectionTime:
            return 220;
        case ActivityInfoSectionMore:
            return 50;
        case ActivityInfoSectionDiscuss:
            //TODO:获取本活动的评论条目高度
            return 44;
        default:
            NSLog(@"ActivityReadyTabController 错误的tableView section:%i",indexPath.section);
            return 0;
    }
}


#pragma - mark other
- (IBAction)barBtnJoinOrExitAction:(id)sender {
    NSLog(@"barBtnJoinOrExitAction");
//TODO:判断自己和活动的关系
    long long aid = [ActivityDataProxy sharedProxy].curAid;
    [[ActivityMessageProxy sharedProxy] sendHttpJoinWithAid:aid];
}

@end
