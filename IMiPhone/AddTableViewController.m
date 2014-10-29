//
//  AddTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AddTableViewController.h"
#import "AddByInputTableViewCell.h"
#import "AddItemTableViewCell.h"
#import "FriendMessageProxy.h"
#import "UserMessageProxy.h"
#import "UserDataProxy.h"

@interface AddTableViewController ()

@property (nonatomic, retain) NSArray *arrTPs;
@property (nonatomic, retain) NSArray *arrGroupMenus4Add;
//@property (nonatomic, retain) AddByInputTableViewCell *userIdCell;
//@property (nonatomic, retain) AddByInputTableViewCell *groupIdCell;

@end

@implementation AddTableViewController

NSInteger const sectionInput = 0;
NSInteger const sectionTP = 1;
NSInteger const sectionGroup = 2;
NSInteger const sectionNum = 3;

NSInteger const ROW_CREATE_QUN = 0;
NSInteger const ROW_CREATE_ZU = 1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"contact" ofType:@"plist"];
    self.arrTPs = [[[NSDictionary alloc] initWithContentsOfFile:plistPath] objectForKey:@"AddTP"];
    self.arrGroupMenus4Add = [[[NSDictionary alloc] initWithContentsOfFile:plistPath] objectForKey:@"GroupMenus4Add"];

    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //[super shouldPerformSegueWithIdentifier:identifier sender:sender];
    return YES;
}

- (IBAction)searchTouchUpInside:(id)sender {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case sectionInput:
            return 2;
        case sectionTP:
            return self.arrTPs.count;
        case sectionGroup:
            return self.arrGroupMenus4Add.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case sectionInput:
        {
            AddByInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addByInputCell" forIndexPath:indexPath];
            if (indexPath.row == 0) {
                cell.tfAddTarget.placeholder = NSLocalizedString(@"Contact.Add.UserID", nil);
                cell.actionType = SEARCH_BY_USER_ID;
                //self.userIdCell = cell;
            }
            else if (indexPath.row == 1)
            {
                cell.tfAddTarget.placeholder = NSLocalizedString(@"Contact.Add.GroupID", nil);
                cell.actionType = SEARCH_BY_GROUP_ID;
                //self.groupIdCell = cell;
            }
            return cell;
        }
        case sectionTP:
        {
            AddItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addByTPCell" forIndexPath:indexPath];
            //cell.actionType = FRIEND_ADD_BY_CONTACT;
            cell.textLabel.text = [self.arrTPs objectAtIndex:indexPath.row];
            return cell;
        }
        case sectionGroup:
        {
            AddItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addForGroup" forIndexPath:indexPath];
            if (indexPath.row == ROW_CREATE_QUN) {
                //cell.actionType = GROUP_CREATE_QUN;
                cell.lblTitle.text = [self.arrGroupMenus4Add objectAtIndex:indexPath.row];
            } else if (indexPath.row == ROW_CREATE_ZU) {
                //cell.actionType = GROUP_CREATE_ZU;
                cell.lblTitle.text = [self.arrGroupMenus4Add objectAtIndex:indexPath.row];
            }
            return cell;
        }
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case sectionGroup: {
            //AddItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addForGroup" forIndexPath:indexPath];
            if (indexPath.row == ROW_CREATE_QUN) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"skipToGroupCreate"
//                                                                    object:nil];
                [self performSegueWithIdentifier:@"contactAdd2groupCreate" sender:self];
            //} else if (indexPath.row == ROW_CREATE_ZU) {
            }
            break;
        }
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - serchResult

- (void)skipToSearchUserResult:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"Add2UserResultSegue" sender:self];
}

- (void)skipToSearchGroupResult:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"Add2GroupResultSegue" sender:self];
}

//- (void)skipToGroupCreate:(NSNotification *)notification {
//    [self performSegueWithIdentifier:@"contactAdd2groupCreate" sender:self];
//    
//}

#pragma mark - IMNWProxyProtocol Method
- (void)registerMessageNotification
{
    //监听搜索用户结果的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToSearchUserResult:) name:NOTI_H__USER_SEARCH_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToSearchGroupResult:) name:NOTI_H__GROUP_INFO_ object:nil];
    

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToGroupCreate:) name:@"skipToGroupCreate" object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
