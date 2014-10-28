//
//  GroupTableViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupTableViewController.h"


@interface GroupTableViewController ()

@end

@implementation GroupTableViewController

#pragma mark - 界面控制

- (void)viewDidLoad {
  NSLog(@"group viewDidLoad");
  [super viewDidLoad];

  [self registerMessageNotification];

  [[GroupDataProxy sharedProxy] getGroupMyList];

  // Uncomment the following line to preserve selection between presentations.ß
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    NSLog(@"group didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"group viewDidAppear.");
    [super viewDidAppear:animated];

    //TODO : 群组刷新时长判断-超过30分钟触发刷新
//    [[GroupMessageProxy sharedProxy] sendGroupMyList:[NSNumber numberWithInteger:0]
//                                         withPageNum:[NSNumber numberWithInteger:50]];

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groupList2viewInfoSegue"]) {
//        GroupInfoViewController *nextController = segue.destinationViewController;
//        nextController.hidesBottomBarWhenPushed = YES;
    }
}


#pragma mark - 数据加载

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"group numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"group numberOfRowsInSection");
    return [[GroupDataProxy sharedProxy] countGroupMyList];
//    NSMutableArray *list = [[GroupDataProxy sharedProxy] getGroupMyList];
//    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupListCell" forIndexPath:indexPath];

    // Configure the cell...
    [cell fillAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 消息处理

- (void)registerMessageNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didShowGroupMyList:)
                                                 name:NOTI_H__GROUP_MYLIST_
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didShowGroupMyList:(NSNotification *)notification {
    //NSLog(@"准备重新显示数据：共%i条",[[GroupDataProxy sharedProxy] countGroupMyList]);
    [self.tableView reloadData];
}


/**/

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
