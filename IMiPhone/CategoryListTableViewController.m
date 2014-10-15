//
//  CategoryListTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "CategoryListTableViewController.h"
#import "CategoryListTableViewCell.h"

//@interface CategoryListTableViewController ()
//
//@end

@implementation CategoryListTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [[FriendDataProxy sharedProxy] getCountOfUsers:USER_LIST_FOR_CURR];
  //  NSArray *listUserInfo;
  //  uint currUserListType = [FriendDataProxy sharedProxy].currUserListType;
  //  if (currUserListType == USER_LIST_FOR_FOCUS) {
  //    listUserInfo = [FriendDataProxy sharedProxy].listMyFocus;
  //  } else if (currUserListType == USER_LIST_FOR_FANS) {
  //    listUserInfo = [FriendDataProxy sharedProxy].listMyFans;
  //  } else {
  //    return 0;
  //  }
  //  return [listUserInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CategoryListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"CellUserList"
                                      forIndexPath:indexPath];

  [cell fillWithIndexPath:indexPath];

  return cell;
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
