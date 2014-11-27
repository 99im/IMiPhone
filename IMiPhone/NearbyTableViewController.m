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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //临时跳转到创建活动
//    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"ActivityCreateTabelController"];
//    [self presentViewController:controller animated:NO completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NearbyVipTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"nearbyVipCell" forIndexPath:indexPath];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell0;
    }
    else if (indexPath.row == 1){
        NearbyBabyTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"nearbyBabyCell" forIndexPath:indexPath];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    else if (indexPath.row == 2){
        NearbyStarTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"nearbyStarCell" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
    else if (indexPath.row == 3){
        NearbyAngleTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"nearbyAngleCell" forIndexPath:indexPath];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
    else if (indexPath.row == 4){
        NearbyClubManagerTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"nearbyClubManagerCell" forIndexPath:indexPath];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }
    else if (indexPath.row == 5){
        NearbyClubTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"nearbyClubCell" forIndexPath:indexPath];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell5;
    }
    else if (indexPath.row == 6){
        NearbyGroupRecruitTableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:@"nearbyGroupRecruitCell" forIndexPath:indexPath];
        cell6.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell6;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5 || indexPath.row == 6) {
        return 120;
    }
    return 80;
}


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

@end
