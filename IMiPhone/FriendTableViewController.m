//
//  FriendListTableViewController.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendTableViewController.h"
#import "FriendMessageProxy.h"
#import "FriendDataProxy.h"
#import "FriendTableViewCellSearch.h"
#import "FriendTableViewCellUser.h"
#import "FriendTableViewCellViewContact.h"
#import "UserDataProxy.h"
#import "UserMessageProxy.h"
#import "UserShowViewController.h"

@interface FriendTableViewController ()

@end

@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FriendTable2UserInfo"]) {
        UserShowViewController *userShowViewController = segue.destinationViewController;
        userShowViewController.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return [[FriendDataProxy sharedProxy] mutableArrayFriends].count;
    }
    else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCellSearch" forIndexPath:indexPath];
        
    }
    else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCellUser" forIndexPath:indexPath];
        DPFriend *friend = [[[FriendDataProxy sharedProxy] mutableArrayFriends] objectAtIndex:indexPath.row];
        DPUser *user = [[UserDataProxy sharedProxy] getUserInfoFromUid:friend.uid];
        if (user) {
            [((FriendTableViewCellUser *)cell).lblNick setText:user.nick];
            ((FriendTableViewCellUser *)cell).data = user;
        }
        else {
            NSAssert(YES, @"数据中心没有找到用户信息！");
        }
    }
    else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCellViewContact" forIndexPath:indexPath];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IMNWProxyProtocol Method
- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiceFriendListData:) name:NOTI__FRIEND_FRIEND_LIST_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchPortrait:) name:NOTIFY_FRIEND_TABLE_VIEW_CELL_USER_TOUCH_PORTRAIT object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiceFriendListData:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)touchPortrait:(NSNotification *)notification
{
    [UserDataProxy sharedProxy].showUserInfoRleation = RELATION_FRIEND;
    [UserDataProxy sharedProxy].showUserInfoUid = ((DPUser *)notification.object).uid ;
    [self performSegueWithIdentifier:@"FriendTable2UserInfo" sender:self];
    
}

@end
