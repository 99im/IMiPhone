//
//  CategoryTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "FriendMessageProxy.h"


@interface CategoryTableViewController ()

@property(nonatomic, retain) NSArray *arrCategorys;

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSBundle *bundle = [NSBundle mainBundle];
  NSString *plistPath = [bundle pathForResource:@"contact" ofType:@"plist"];
  self.arrCategorys = [[[NSDictionary alloc] initWithContentsOfFile:plistPath]
      objectForKey:@"Category"];
    
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [[FriendMessageProxy sharedProxy] sendHttpBrief];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  NSString *categoryId = nil;
  for (NSDictionary *dicCategory in self.arrCategorys) {
    if ([cell.textLabel.text
            isEqualToString:[dicCategory objectForKey:@"title"]]) {
      categoryId = [dicCategory objectForKey:@"id"];
      break;
    }
  }
  if ([categoryId isEqualToString:@"focus"]) {
      [FriendDataProxy sharedProxy].currUserListType = USER_LIST_FOR_FOCUS;
      [self performSegueWithIdentifier:@"Category2FocusAndFanListSegue" sender:self];
      
//    [[FriendMessageProxy sharedProxy]
//        sendTypeFocusList:[NSNumber numberWithInt:0]
//              withPageNum:[NSNumber numberWithInt:LIST_PAGENUM]];
  } else if ([categoryId isEqualToString:@"fan"]) {
      [FriendDataProxy sharedProxy].currUserListType = USER_LIST_FOR_FANS;
      [self performSegueWithIdentifier:@"Category2FocusAndFanListSegue" sender:self];
  }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return self.arrCategorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"CategoryTVCell"
                                      forIndexPath:indexPath];
  cell.textLabel.text =
      [[self.arrCategorys objectAtIndex:indexPath.row] objectForKey:@"title"];
  [cell.imageView
      setImage:[UIImage
                   imageNamed:[[self.arrCategorys objectAtIndex:indexPath.row]
                                  objectForKey:@"image"]]];
    NSInteger personNum;
    NSString *cellId = [[self.arrCategorys objectAtIndex:indexPath.row] objectForKey:@"id"];
    if ([cellId isEqualToString:@"fan"]) {
        personNum = [FriendDataProxy sharedProxy].fanTotal;
    }
    else if ([cellId isEqualToString:@"focus"]) {
        personNum = [FriendDataProxy sharedProxy].focusTotal;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li%@",(long)personNum ,NSLocalizedString(@"Unit.Person", nil)];

  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the
array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
*)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - register and remove notification listener

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealFriendBrief:) name:NOTI_H__FRIEND_BRIEF_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealFriendBrief:(NSNotification *)notification
{
    [self.tableView reloadData];
}



@end
