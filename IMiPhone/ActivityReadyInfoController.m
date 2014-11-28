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


- (IBAction)barBtnJoinOrExitAction:(id)sender;

@end

@implementation ActivityReadyInfoController

static NSString *ActivityInfoTitleCell = @"ActivityInfoTitleCell";
static NSString *ActivityInfoTableApplyOKCell = @"ActivityInfoApplyOkCell";
static NSString *ActivityInfoBelongCell = @"ActivityInfoBelongCell";
static NSString *ActivityInfoApplyCell = @"ActivityInfoApplyCell";
static NSString *ActivityInfoCreatorCell = @"ActivityInfoCreatorCell";
static NSString *ActivityInfoTableMoreCell = @"ActivityInfoMoreCell";
static NSString *ActivityInfoTableDiscussCell = @"ActivityInfoDiscussCell";

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
    self.dpActivity =  [[ActivityDataProxy sharedProxy] getActivityWithAid:curAid needRequest:YES];
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
            UITableViewCell *cellBelong = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoBelongCell forIndexPath:indexPath];
            return cellBelong;
        }
    }
    else if (indexPath.section == ActivityInfoSectionJoinMembers) {
        UITableViewCell *cellJoinMembers = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoApplyCell forIndexPath:indexPath];
        return cellJoinMembers;
    }
    else if (indexPath.section == ActivityInfoSectionTime) {
        UITableViewCell *cellCreator = [self.tableView dequeueReusableCellWithIdentifier:ActivityInfoCreatorCell forIndexPath:indexPath];
        return cellCreator;
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
    CGFloat height;
//    UITableViewCell *cell;
//    NSString *cellIdentify;
    switch (indexPath.section) {
        case ActivityInfoSectionTitle:
//            cellIdentify = ActivityInfoTitleCell;
            height = 65;
            break;
        case ActivityInfoSectionCreatorOrApplyOk:
            if (self.isTemp) {
//                cellIdentify = ActivityInfoTableApplyOKCell;
                height = 100;
            }
            else {
//                cellIdentify = ActivityInfoBelongCell;
                height = 35;

            }
            break;
        case ActivityInfoSectionJoinMembers:
//            cellIdentify = ActivityInfoApplyCell;
            height = 90;
            break;
        case ActivityInfoSectionTime:
//            cellIdentify = ActivityInfoCreatorCell;
            height = 134;
            break;
        case ActivityInfoSectionMore:
//            cellIdentify = ActivityInfoTableMoreCell;
            height = 152;
            break;
        case ActivityInfoSectionDiscuss:
            //TODO:获取本活动的评论条目高度
//             cellIdentify = ActivityInfoTableDiscussCell;
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
- (IBAction)barBtnJoinOrExitAction:(id)sender {
    NSLog(@"barBtnJoinOrExitAction");
//TODO:判断自己和活动的关系
    long long aid = [ActivityDataProxy sharedProxy].curAid;
    [[ActivityMessageProxy sharedProxy] sendHttpJoinWithAid:aid];
}

@end
