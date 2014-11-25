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
        UserD1TableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"userD1cell" forIndexPath:indexPath];
        return cell1;
    }
    else if (indexPath.row == 1) {
        UserD2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"userD2cell" forIndexPath:indexPath];
        return cell2;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
        return 30;
    else if (indexPath.row == 1)
        return 70;
    
    return 0;
}
@end
