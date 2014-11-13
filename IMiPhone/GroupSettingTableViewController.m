//
//  GroupSettingTableViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupSettingTableViewController.h"

@interface GroupSettingTableViewController ()

@end

@implementation GroupSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 5;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

#pragma mark - 消息监听
- (void)registerMessageNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGroupExit:)
                                                 name:NOTI_H__GROUP_EXIT_
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didGroupExit:(NSNotification *)notification {
    //NSLog(@"退群：%@" , notification.userInfo);
    if (notification.object) {
        NSLog(@"退群失败");
    } else if(notification.userInfo) {
        DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
        long long gid = [[notification.userInfo objectForKey:KEYQ_H__GROUP_EXIT__GID] longLongValue];
        if (dpGroup && dpGroup.gid == gid) {
            dpGroup.myRelation = GROUP_RELATION_NONE;
            NSLog(@"退群成功:%qi", gid);
            //TODO: 开始重定向到群列表页
        }

    }
}


#pragma mark - 交互动作
- (IBAction)groupExitTouchUp:(id)sender
{
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
    if (dpGroup) {
        if ([GroupDataProxy isGroupOwner:dpGroup]) {//解散群
            // TODO: 解散群
        }
        else {//退出群
            [[GroupMessageProxy sharedProxy] sendGroupExit:dpGroup.gid];
        }
    }
    else {
        NSLog(@"出现异常：退出该群");
    }
}
@end
