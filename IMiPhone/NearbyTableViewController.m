//
//  NearbyTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NearbyTableViewController.h"

@interface NearbyTableViewController ()


@end

@implementation NearbyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self registerMessageNotification];
    [self getNearbyList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //获取用户当前位置
    DPLocation *dpLocation = [[LocationDataProxy sharedProxy] getUserLocation];
    NSLog(@"%i <%f, %f>", (int)dpLocation.dataStatus , dpLocation.latitude, dpLocation.longitude);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[LocationDataProxy sharedProxy] stopUpdatingLocation];
}

- (void) viewDidDisappear:(BOOL)animated{
    [self reomveMessageNotification];
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableArray *arr = [[DiscoveryDataProxy sharedProxy] arrNearbyList];
    if (arr == nil)
        return 0;
    else
        return arr.count;
    //return 0;//[[DiscoveryDataProxy sharedProxy] countOfArrNearbyList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DPNearby *dpNearby = [[DiscoveryDataProxy sharedProxy] getNearbyListInfoAtRow:indexPath.row];
    if (dpNearby.type == NEARBY_USER) {
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpNearby.dataID];
        NSInteger role = [dpUser.roles[0] integerValue];
        NSString *nick = dpUser.nick;
        NSInteger distance = dpNearby.distance;
        
        
        //0 普通 1 宝贝 2助教 3天使 4 俱乐部经理 5明星
        if(role == 0){
            NearbyVipTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"nearbyVipCell" forIndexPath:indexPath];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell0.lblNickName setText:nick];
            [cell0.lblDistance setText:[NSString stringWithFormat:@"%i",distance]];
            cell0.imageVip.hidden = NO;
            return cell0;
        }
        else if (role == 1){
            NearbyBabyTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"nearbyBabyCell" forIndexPath:indexPath];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell1.lblNickName setText:nick];
            [cell1.lblDistance setText:[NSString stringWithFormat:@"%i",distance]];
            return cell1;
        }
        else if (role == 2){
            return nil;
        }
        else if (role == 3){
            NearbyAngleTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"nearbyAngleCell" forIndexPath:indexPath];
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell3.lblNickName setText:nick];
            [cell3.lblDistance setText:[NSString stringWithFormat:@"%i",distance]];
            return cell3;
        }
        else if (role == 4){
            NearbyClubManagerTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"nearbyClubManagerCell" forIndexPath:indexPath];
            cell4.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell4.lblNickName setText:nick];
            [cell4.lblDistance setText:[NSString stringWithFormat:@"%i",distance]];
            return cell4;
        }
        else if (role == 5){
            NearbyStarTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"nearbyStarCell" forIndexPath:indexPath];
            cell5.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell5.lblNickName setText:nick];
            [cell5.lblDistance setText:[NSString stringWithFormat:@"%i",distance]];
            return cell5;
        }
    }
    else if (dpNearby.type == NEARBY_CLUB){
        DPNearbyClub *dpNearbyClub = [[ClubDataProxy sharedProxy] getNearbyClubByClubID:dpNearby.dataID];
        long long clubID = dpNearbyClub.clubId;
        NSString *name = dpNearbyClub.name;
        NearbyClubTableViewCell *cellClub = [tableView dequeueReusableCellWithIdentifier:@"nearbyClubCell" forIndexPath:indexPath];
        cellClub.selectionStyle = UITableViewCellSelectionStyleNone;
        [cellClub.lblClunName setText:name];
        [cellClub.lblClubID setText:[NSString stringWithFormat:@"%lld", clubID]];
        return cellClub;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DPNearby *dpNearby = [[DiscoveryDataProxy sharedProxy] getNearbyListInfoAtRow:indexPath.row];
    if(dpNearby.type == NEARBY_CLUB)
        return 120;
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPNearby *dpNearby = [[DiscoveryDataProxy sharedProxy] getNearbyListInfoAtRow:indexPath.row];
    if (dpNearby.type == NEARBY_USER) {
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpNearby.dataID];
        [UserDataProxy sharedProxy].showUserInfoUid = dpUser.uid;
        UserShowViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"userInfoView"];
        [self.navigationController pushViewController:viewController animated:YES];

    }
}

#pragma mark - 消息处理
- (void) registerMessageNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(didShowNearbyList:)
                                          name:NOTI_H__DISCOVERY_NEARBYLIST_
                                          object:nil];
    
    //LBS_NOTI_didUpdateLocations
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didrefreshNearbyList:)
                                                 name:LBS_NOTI_didUpdateLocations
                                               object:nil];
}

- (void) reomveMessageNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) didShowNearbyList:(NSNotification *)notification{
    [self.tableview reloadData];
}

- (void) didrefreshNearbyList:(NSNotification *)notification{
    if(notification.object != nil)
         NSLog(@"没有开启获取地理位置");
    else
        [self getNearbyList];
}

- (void)getNearbyList{
    [[DiscoveryDataProxy sharedProxy]getNearbyList:SEND_NEARBYLIST_HTTP_YES];
}


@end
