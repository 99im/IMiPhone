//
//  CategoryListTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "CategoryListTableViewController.h"
#import "CategoryListTableViewCell.h"
#import "UserDataProxy.h"
#import "UserMessageProxy.h"
#import "FriendDataProxy.h"

@interface CategoryListTableViewController ()


@end

@implementation CategoryListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[FriendDataProxy sharedProxy] clearArrCurrentPageList];
    if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FANS) {
        self.title = NSLocalizedString(@"Category.Fan", nil);
       
        }
    else if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FOCUS) {
        self.title = NSLocalizedString(@"Category.Focus", nil);
    }
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FANS) {
        [[FriendDataProxy sharedProxy] getFanListInRange:NSMakeRange(0, LIST_PAGENUM)];
    }
    else if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FOCUS) {
        [[FriendDataProxy sharedProxy] getFocusListInRange:NSMakeRange(0, LIST_PAGENUM)];
    }
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - 注册与移除通知监听
- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealFanList:) name:NOTI_H__FRIEND_FAN_LIST_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealFocusList:) name:NOTI_H__FRIEND_FOCUS_LIST_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealFanList:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)dealFocusList:(NSNotification *)notification
{
    if (notification.object != nil) {
        //服务端返回错误码的处理
        NSLog(@"%@",notification.object);
    }
    else {
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [FriendDataProxy sharedProxy].arrCurrentPageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CategoryListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"ContactFocusAndFanTableCell"
                                      forIndexPath:indexPath];

    if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FANS) {
        [cell fillWithDPFanUser:[[FriendDataProxy sharedProxy].arrCurrentPageList objectAtIndex:indexPath.row]];
    }
    else if ([FriendDataProxy sharedProxy].currUserListType == USER_LIST_FOR_FOCUS) {
        [cell fillWithDPFocusUser:[[FriendDataProxy sharedProxy].arrCurrentPageList objectAtIndex:indexPath.row]];
    }
    else {
        NSLog(@"非法currUserListType!!!");
    }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DPUser *dpUser;
    if (USER_LIST_FOR_FOCUS == [FriendDataProxy sharedProxy].currUserListType) {
         [UserDataProxy sharedProxy].showUserInfoRleation = RELATION_FOCUS;
        DPFocusUser *dpFocusUser = [[FriendDataProxy sharedProxy].arrCurrentPageList objectAtIndex:indexPath.row];
        dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpFocusUser.focusUid];
           }
    else if (USER_LIST_FOR_FANS == [FriendDataProxy sharedProxy].currUserListType) {
        [UserDataProxy sharedProxy].showUserInfoRleation = RELATION_FAN;
        DPFanUser *dpFanUser = [[FriendDataProxy sharedProxy].arrCurrentPageList objectAtIndex:indexPath.row];
        dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpFanUser.fanUid];


    }
    if (dpUser == nil) {
        NSLog(@"不能找到用户信息(categoryListTable didSelectRowAtIndexPath)");
    }
    else
    {
        [UserDataProxy sharedProxy].showUserInfoUid = dpUser.uid ;
        [self performSegueWithIdentifier:@"ContactFocusAndFanList2UserInfo" sender:self];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the
array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
*)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
