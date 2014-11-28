//
//  GroupMembersTableViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupMembersTableViewController.h"

@interface GroupMembersTableViewController ()

@property (nonatomic, retain) NSMutableArray *members;

@end

@implementation GroupMembersTableViewController

@synthesize members = _members;

- (void)viewDidLoad {
    [super viewDidLoad];
    _members = [[GroupDataProxy sharedProxy] getGroupMembersCurrent];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupMemberTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellGroupMember" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    DPGroupMember *member = [_members objectAtIndex:row];
    [cell drawCellWithGroupMember:member];
    return cell;
}

#pragma mark - 消息监听
//- (void)registerMessageNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didSendGroupMembers:)
//                                                 name:NOTI_H__GROUP_MEMBERS_
//                                               object:nil];
//}
//
//- (void)removeMessageNotification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

//- (void)didSendGroupMembers:(NSNotification *)notification {
//    if (notification.object) {
//        //出错了
//    } else {
//        _groupMembers = [[GroupDataProxy sharedProxy] getGroupMembersCurrent];
//        [self.tableView reloadData];
//    }
//}


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

@end
