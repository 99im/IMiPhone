//
//  UserDynamicViewController.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/24.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserDynamicViewController.h"

@interface UserDynamicViewController ()

@end

@implementation UserDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnParentInterface:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"取消建群");
//    }];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回上一级");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UserD0TableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"userD0cell" forIndexPath:indexPath];
        cell0.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell0;
    }
    else if (indexPath.row == 1) {
        UserD1TableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"userD1cell" forIndexPath:indexPath];
        cell1.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell1;
    }
    else if (indexPath.row == 2){
        UserD2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"userD2cell" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell2;
    }
    else if (indexPath.row == 3){
        UserD3TableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"userD3cell" forIndexPath:indexPath];
        cell3.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell3;
    }
    else if (indexPath.row == 4){
        UserD4TableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"userD4cell" forIndexPath:indexPath];
        cell4.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell4;
    }
    else if (indexPath.row == 5){
        UserD5TableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"userD5cell" forIndexPath:indexPath];
        cell5.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell5;
    }
    else if (indexPath.row == 6){
        UserD6TableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:@"userD6cell" forIndexPath:indexPath];
        cell6.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell6;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
        return 80;
    else if (indexPath.row == 1)
        return 35;
    else if (indexPath.row == 2)
        return 75;
    else if (indexPath.row == 3)
        return 220;
    else if (indexPath.row == 4)
        return 120;
    else if (indexPath.row == 5)
        return 250;
    else if (indexPath.row == 6)
        return 140;
    
    return 0;
}
@end
