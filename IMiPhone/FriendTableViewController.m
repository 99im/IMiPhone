//
//  FriendListTableViewController.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendTableViewController.h"
#import "FriendMessageProxy.h"
#import "FriendDataProxy.h"
#import "FriendTableViewCellUser.h"
#import "UserDataProxy.h"
#import "UserMessageProxy.h"
#import "UserShowViewController.h"


//typedef NS_ENUM(NSInteger, FriendTableViewSection) ｛


@interface FriendTableViewController ()

@property (nonatomic, retain) UIButton *btnViewContact;
@property (nonatomic, retain) NSMutableArray *arrFriendsData;
@property (nonatomic, retain) NSArray *searchResults;

@end

@implementation FriendTableViewController

@synthesize searchBar;

@synthesize btnViewContact;
@synthesize arrFriendsData;
@synthesize searchResults;
@synthesize searchDisplayController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self registerMessageNotification];
    [[FriendMessageProxy sharedProxy] sendTypeFriendList:[NSNumber numberWithInteger:0] withPageNum:[NSNumber numberWithInteger:50]];
    //添加footview 按钮
    UITableViewHeaderFooterView *view = [self.tableView footerViewForSection:0];
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 57.0)];
    btnViewContact = [[UIButton alloc] initWithFrame:footerView.frame];
    btnViewContact.titleLabel.text = NSLocalizedString(@"View.Contact.Friends", null);
    [footerView addSubview:btnViewContact];
//    [view addSubview:btnViewContact];
//    [self.tableView addSubview:btnViewContact];
    
    //组装table数据
    self.arrFriendsData = [NSMutableArray array];
    for (NSInteger i = 0; i < [[FriendDataProxy sharedProxy] mutableArrayFriends].count; i++) {
        DPFriend *friend = [[[FriendDataProxy sharedProxy] mutableArrayFriends] objectAtIndex:i];
        DPUser *user = [[UserDataProxy sharedProxy] getUserInfoFromUid:friend.uid];
        if (user) {
            [self.arrFriendsData addObject:user];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FriendTable2UserInfo"]) {
        UserShowViewController *userShowViewController = segue.destinationViewController;
        userShowViewController.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
//     if ([tableView           isEqual:self.searchDisplayController.searchResultsTableView]){
//
    
    if([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return searchResults.count;
    }
    else {
        return arrFriendsData.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"FriendTableViewCellUser";
    UITableViewCell *cell = nil;
    NSLog(@"refresh:%@..self:%@,",tableView,self.tableView);
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    DPUser *user;
    
    NSLog(@"self.searchDisplayController%@",self.searchDisplayController);
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
         user = [self.searchResults objectAtIndex:indexPath.row];
    }
    else {
         user = [self.arrFriendsData objectAtIndex:indexPath.row];
    }
    if (user) {
            [((FriendTableViewCellUser *)cell).lblNick setText:user.nick];
            ((FriendTableViewCellUser *)cell).data = user;
    }
    else {
        NSAssert(YES, @"数据源中没有找到用户信息！");
    }
    return cell;
}

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

#pragma mark - IMNWProxyProtocol Method
- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiceFriendListData:) name:NOTI__FRIEND_FRIEND_LIST_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchPortrait:) name:NOTIFY_FRIEND_TABLE_VIEW_CELL_USER_TOUCH_PORTRAIT object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiceFriendListData:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)touchPortrait:(NSNotification *)notification
{
    [UserDataProxy sharedProxy].showUserInfoRleation = RELATION_FRIEND;
    [UserDataProxy sharedProxy].showUserInfoUid = ((DPUser *)notification.object).uid ;
    [self performSegueWithIdentifier:@"FriendTable2UserInfo" sender:self];
    
}


- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {

    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"nick contains[cd] %@",                                     searchText];
    
    self.searchResults = [self.arrFriendsData filteredArrayUsingPredicate:resultPredicate];
    
}

#pragma mark - UISearchDisplayController delegate methods

//UISearchDisplayController的委托方法，负责响应搜索事件：
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:searchOption]];
    
    return YES;
    
}

@end
