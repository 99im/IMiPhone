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

- (void)viewDidLoad {
  NSLog(@"group viewDidLoad");
  [super viewDidLoad];

  [self registerMessageNotification];

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
    [[GroupMessageProxy sharedProxy] getMyJoinGroups:[NSNumber numberWithInteger:0]
                                         withPageNum:[NSNumber numberWithInteger:50]];
    //self.scrollView.contentSize = CGSizeMake(320, 751);
    //self.scrollView.frame = CGRectMake(0, 64, 320, 504);
    //NSLog(@" self.scrollView.contentSize %f,%f", self.scrollView.contentSize.height, self.scrollView.contentSize.width);
    //NSLog(@" self.scrollView.frame %f,%f", self.scrollView.frame.size.height, self.scrollView.frame.size.width);

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FriendTable2UserInfo"]) {
        GroupInfoController *nextController = segue.destinationViewController;
        nextController.hidesBottomBarWhenPushed = YES;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"group numberOfSectionsInTableView");
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"group numberOfRowsInSection");
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupListCell" forIndexPath:indexPath];

    // Configure the cell...
    [cell fillAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Notification
- (void)registerMessageNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showGroupInfo:)
                                                 name:NOTI_GROUP_SHOW_INFO
                                               object:nil];
}

- (void)removeMessageNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showGroupInfo:(NSNotification *)notification {
    //[GroupDataProxy sharedProxy].showUserInfoRleation = RELATION_FRIEND;
    //[GroupDataProxy sharedProxy].showUserInfoUid = ((DPUser *)notification.object).uid ;
    //[self performSegueWithIdentifier:@"groupTable2GroupDetail" sender:self];

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
