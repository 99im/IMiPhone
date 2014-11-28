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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ActivityCellTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
        [cell0 creatBtn];
        return cell0;
    }
    else if (indexPath.section == 1) {
        FriendDynamicTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"friendDynamicCell" forIndexPath:indexPath];
        [cell1 creatHead:self.dataFDList];
        return cell1;
    }
    else if (indexPath.section == 2){
        HavingFunTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"havingFunCell" forIndexPath:indexPath];
        NSString *message = [self.dataHFList objectForKey:@"message"];
        NSMutableDictionary *nearbyGroup = [self.dataHFList objectForKey:@"nearbyGroup"];
        [cell2 creatServer:message andDescription:[nearbyGroup objectForKey:@"groupName"]];
        return cell2;
    }
    else if (indexPath.section == 3){
        ServiceTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
        NSString *server = [[self.dataSList objectAtIndex:indexPath.row] objectForKey:@"gname"];
        NSString *description = [[self.dataSList objectAtIndex:indexPath.row] objectForKey:@"gdescription"];
        [cell3 creatServer:server andDescription:description];
        return cell3;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 1;
    else if(section == 1)
        return 1;
    else if (section == 2)
        return 1;
    else
        return self.dataSList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else if(section == 1)
        return @"好友动态";
    else if (section == 2)
        return @"玩乐";
    else
        return @"服务";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 15)];
        lable.text = @"查看更多";
        lable.textAlignment = NSTextAlignmentCenter;
        
        return lable;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 20;
    }
     return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
}



- (void) didShowList{
    [self.tableview reloadData];
}

- (void)registerMessageNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealnotificationcreatactivity:) name:NOTI_ACTIVITY_CELL_BTN_CREATACTIVITY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealnotificationjoinactivity:) name:NOTI_ACTIVITY_CELL_BTN_JOINACTIVITY object:nil];
}

- (void)dealnotificationcreatactivity:(NSNotification *) notification{
    //  TO DO
}

- (void)dealnotificationjoinactivity:(NSNotification *) notification{
    //TO DO
}

@end
