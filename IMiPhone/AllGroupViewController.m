//
//  AllGroupViewController.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AllGroupViewController.h"

@interface AllGroupViewController ()

@end

@implementation AllGroupViewController
@synthesize nowGroupList;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //获取FindList.plist数据
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"FindList" ofType:@"plist"];
//    self.nearbyGroupList = [[[[NSDictionary alloc] initWithContentsOfFile:plistPath] valueForKey:@"玩乐"] objectForKey:@"nearbyGroups"];
//    self.nearbyGroupRecruitList = [[[[NSDictionary alloc] initWithContentsOfFile:plistPath] valueForKey:@"玩乐"] objectForKey:@"nearbyGroupRecruit"];
    //
    [self registerMessageNotification];
    [[GroupDataProxy sharedProxy] getGroupSearchList:SEND_HTTP_AUTO];
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    [self reomveMessageNotification];
    [super viewDidDisappear:animated];
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
//暂时不用，显示的是全部群组信息
- (void) settingNowGroupList:(NSInteger)tag{
    if (tag == 1)
        self.nowGroupList = self.nearbyGroupRecruitList;
    else
        self.nowGroupList = self.nearbyGroupList;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //return self.nowGroupList.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allGroupCell" forIndexPath:indexPath];
    //[cell paddingDataForCell:[[self.nowGroupList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    [cell paddingDataForCell:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    for (NSInteger i = 0; i < self.nowGroupList.count; i ++) {
//        if (section == i) {
//            NSLog(@"%lu",(unsigned long)[[self.nowGroupList objectAtIndex:i] count]);
//            return [[self.nowGroupList objectAtIndex:i] count];
//        }
//    }
//    return 0;
    return [[GroupDataProxy sharedProxy] countGroupSearchList];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    for (NSInteger i = 0; i < self.nowGroupList.count; i ++) {
//        if (section == i) {
//           
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
//            
//            UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 22)];
//            lblName.font = [UIFont fontWithName:@"Arial" size:12.0f];
//            NSString *str = @"清华科技园";
//            NSString *strI = [NSString stringWithFormat:@"%ld",(long)i];
//            str = [str stringByAppendingString:strI];
//            lblName.text = str;
//            lblName.textAlignment = NSTextAlignmentLeft;
//            
//            UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(200, 2, 100, 22)];
//            lblNum.font = [UIFont fontWithName:@"Arial" size:12.0f];
//            NSString *strN = @"个群组";
//            NSInteger num = [[self.nowGroupList objectAtIndex:i] count];
//            NSString *strNum = [NSString stringWithFormat:@"%ld",(long)num];
//            strNum = [strNum stringByAppendingString:strN];
//            lblNum.text = strNum;
//            lblNum.textAlignment = NSTextAlignmentRight;
//            
//            [view addSubview:lblName];
//            [view addSubview:lblNum];
//            
//            return view;
//        }
//    }
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    
      UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 22)];
      lblName.font = [UIFont fontWithName:@"Arial" size:12.0f];
      NSString *str = @"清华科技园";
      lblName.text = str;
      lblName.textAlignment = NSTextAlignmentLeft;
    
      UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(200, 2, 100, 22)];
      lblNum.font = [UIFont fontWithName:@"Arial" size:12.0f];
      NSString *strN = @"个群组";
      NSInteger num = [[GroupDataProxy sharedProxy] countGroupSearchList];
      NSString *strNum = [NSString stringWithFormat:@"%ld",(long)num];
      strNum = [strNum stringByAppendingString:strN];
      lblNum.text = strNum;
      lblNum.textAlignment = NSTextAlignmentRight;
    
      [view addSubview:lblName];
      [view addSubview:lblNum];
                
     return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
}

#pragma mark - 消息处理
- (void) registerMessageNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(didShowNearbyGroupList:)
                                          name:NOTI_H__GROUP_SEARCH_
                                          object:nil];
}

- (void) reomveMessageNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) didShowNearbyGroupList:(NSNotification *)notification {
    [self.tableView reloadData];
}

@end
