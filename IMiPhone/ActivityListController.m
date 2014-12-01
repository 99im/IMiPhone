//
//  ActivityListController.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityListController.h"


@interface ActivityListController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *arrCurActivitys;

- (IBAction)segmentOnChanged:(id)sender;

@end

@implementation ActivityListController

static NSInteger kActivityListPageNum = 50;

static NSString *kActivityCellId = @"ActivityListTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerMessageNotification];
    self.arrCurActivitys = [[ActivityDataProxy sharedProxy] getNearbyActivityListWithStart:0 withPageNum:kActivityListPageNum needRequest:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeMessageNotification];
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealNotifyNearby:) name:NOTI_H__ACTIVITY_NEARBY_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kActivityCellId forIndexPath:indexPath];
   
    DPNearbyActivity *dpNearbyActivity = [self.arrCurActivitys objectAtIndex:indexPath.row];
    DPActivity *dpActivity = [[ActivityDataProxy sharedProxy] getActivityWithAid:dpNearbyActivity.aid needRequest:NO];

//TODO:活动地点
//    cell.lblAddress = dpActivity.
    //TODO:活动地点
//    cell.lblBeginTime
    //TODO:活动归属
//    cell.lblBelong.text = [NSLocalizedString(@"Activity.Belong", nil) stringByAppendingString:dpActivity.beLong];
    DPUser *dpUserCreator = [[UserDataProxy sharedProxy] getUserByUid:dpActivity.createrUid];
    cell.lblCreator.text = [NSLocalizedString(@"Activity.Creator", nil) stringByAppendingString:dpUserCreator.nick];
    
    cell.lblCurNum.text =
    [NSString stringWithFormat:@"%@(%li/%li)", NSLocalizedString(@"Activity.CurNum", nil), (long)dpActivity.curNum, (long)dpActivity.maxNum];
    cell.lblDate.text = [NSLocalizedString(@"Activity.Date", nil) stringByAppendingString:dpActivity.beginTime];
    //TODO:每人费用根据费用类型显示
//    cell.lblPay.text = [NSLocalizedString(@"Activity.Date", nil) stringByAppendingString:dpActivity.];
//TODO:人气
//    cell.lblRenqi.text
    cell.lblTitle.text = dpActivity.title;
    return cell;
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrCurActivitys.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPNearbyActivity *dpNearbyActivity = [self.arrCurActivitys objectAtIndex:indexPath.row];
    [ActivityDataProxy sharedProxy].curAid = dpNearbyActivity.aid;
    
    [ActivityDataProxy sharedProxy].curRelation = dpNearbyActivity.myReleation;
    
    [self performSegueWithIdentifier:@"ActivityList2ActivityInfo" sender:self];
}

#pragma mark - 用户操作响应

- (IBAction)segmentOnChanged:(id)sender {
    self.arrCurActivitys = [[ActivityDataProxy sharedProxy] getNearbyActivityListWithStart:0 withPageNum:kActivityListPageNum needRequest:YES];
}

#pragma mark - deal notify
- (void)dealNotifyNearby:(NSNotification *)notify
{
    self.arrCurActivitys = [[ActivityDataProxy sharedProxy] getNearbyActivityListWithStart:0 withPageNum:kActivityListPageNum needRequest:NO];
    [self.tableView reloadData];
}
@end
