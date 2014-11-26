//
//  CommonUserViewController.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "CommonUserViewController.h"

@interface CommonUserViewController ()

@end

@implementation CommonUserViewController
@synthesize lblUserNick;
@synthesize lblUserOid;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.contentInset = UIEdgeInsetsMake(- 70, 0, 0, 0);

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
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回上一级");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UserPictureTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"userPicturecell" forIndexPath:indexPath];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell0;
    }
    else if (indexPath.row == 1) {
        UserInfoTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"userInfocell" forIndexPath:indexPath];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    else if (indexPath.row == 2){
        UserDynamiceTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"userDynamiccell" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
    else if (indexPath.row == 3){
        UserSignTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"userSigncell" forIndexPath:indexPath];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
    else if (indexPath.row == 4){
        UserBBSTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"userBBScell" forIndexPath:indexPath];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }
    else if (indexPath.row == 5){
        UserJoinGroupsTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"userJoinGroupscell" forIndexPath:indexPath];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell5;
    }
    else if (indexPath.row == 6){
        UserDescriptionTableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:@"userDescriptioncell" forIndexPath:indexPath];
        cell6.selectionStyle = UITableViewCellSelectionStyleNone;
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
