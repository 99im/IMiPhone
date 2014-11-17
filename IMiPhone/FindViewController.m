//
//  FindViewController.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

@synthesize dictionary;
@synthesize dataFDList;
@synthesize dataHFList;
@synthesize dataSList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    //获取plist中的假数据
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"FindList" ofType:@"plist"];
    self.dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.dataFDList = [self.dictionary valueForKey:@"好友动态"];
    self.dataHFList = [self.dictionary valueForKey:@"玩乐"];
    self.dataSList = [self.dictionary valueForKey:@"服务"];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FriendDynamicTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"friendDynamicCell" forIndexPath:indexPath];
        [cell1 creatHead];
        return cell1;
    }
    else if (indexPath.section == 1){
        HavingFunTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"havingFunCell" forIndexPath:indexPath];
        NSString *message = [self.dataHFList objectForKey:@"message"];
        NSMutableDictionary *nearbyGroup = [self.dataHFList objectForKey:@"nearbyGroup"];
        cell2.LabServer.text = message;
        cell2.LabDescription2.text = [nearbyGroup objectForKey:@"groupName"];
        return cell2;
    }
    else if (indexPath.section == 2){
        ServiceTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
        //cell3.lable1.text = [self.dataSList objectAtIndex:indexPath.row][0];
        cell3.LabServer.text = [[self.dataSList objectAtIndex:indexPath.row] objectForKey:@"gname"];
        cell3.LabDescription.text = [[self.dataSList objectAtIndex:indexPath.row] objectForKey:@"gdescription"];
        return cell3;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 1;
    else if (section == 1)
        return 1;
    else
        return self.dataSList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"好友动态";
    else if (section == 1)
        return @"玩乐";
    else
        return @"服务";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 2)
        return @"查看更多";
    return nil;
}

- (void) didShowList{
    [self.tableview reloadData];
}

@end
