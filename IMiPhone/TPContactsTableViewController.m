//
//  TPContactsTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "TPContactsTableViewController.h"
#import "IMAddressBook.h"
#import "FriendMessageProxy.h"
#import "UserDataProxy.h"
#import "AddressAddTVTableViewCell.h"
#import "AddressInviteTVTableViewCell.h"

@interface TPContactsTableViewController ()

@property (nonatomic, retain) NSMutableArray *arrUsers;
@property (nonatomic, retain) NSMutableArray *arrAddressBookNames;
@property (nonatomic, retain) NSMutableArray *arrAddressBookPhones;

@end

@implementation TPContactsTableViewController
enum
{
    Section_users = 0,
    Section_contact = 1
};

@synthesize arrAddressBookNames;
@synthesize arrAddressBookPhones;
@synthesize arrUsers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.arrAddressBookNames = [NSMutableArray array];
        self.arrAddressBookPhones = [NSMutableArray array];
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
    [self registerMessageNotification];
    //筛选数据
    self.arrUsers = [NSMutableArray array];
    self.arrAddressBookNames = [NSMutableArray array];
    self.arrAddressBookPhones = [NSMutableArray array];
    NSArray *usersFromContact = [[FriendDataProxy sharedProxy] mutableArrayUsersFromContact];
    for (NSInteger i = 0; i < usersFromContact.count; i++) {
        DPUserFromContact *userFromContact = [usersFromContact objectAtIndex:i];
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserInfoFromUid:userFromContact.uid];
        [self.arrUsers addObject:dpUser];
    }
    NSArray *arrContact = [[FriendDataProxy sharedProxy] mutableArrayContact];
    for (NSInteger i = 0; i < arrContact.count; i++) {
        DPContactPerson *dpContactPerson = [arrContact objectAtIndex:i];
        if (dpContactPerson.phones.length > 0) {
            NSArray *arrPhones = [dpContactPerson.phones componentsSeparatedByString:@","];
            for (NSInteger j; j < arrPhones.count; j++) {
                NSString *fullName = [dpContactPerson.firstName stringByAppendingString:dpContactPerson.lastName];
                [self.arrAddressBookNames addObject:fullName];
                [self.arrAddressBookPhones addObject:[arrPhones objectAtIndex:j]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    
    // Return the number of rows in the section.
    if (section == Section_users) {
        return self.arrUsers.count;
    }
    else if (section == Section_contact)
    {
        return self.arrAddressBookNames.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == Section_users) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddressAddTVTableViewCell" forIndexPath:indexPath];
//        (AddR)cell
    }
    else if (indexPath.section == Section_contact) {
         cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddressInviteTVTableViewCell" forIndexPath:indexPath];
    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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

#pragma mark - Notification listen

- (void)registerMessageNotification
{
    //监听通讯录数据获取
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imAddressBookGetData:) name:NOTIFY_IMADRRESSBOOK_GET_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToSearchResult:) name:NOTI__CONTACT_UPLOAD_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)imAddressBookGetData:(NSNotification *)notification
{
    [self.tableView reloadData];
}
- (void)contactUpload:(NSNotification *)notification
{
    [self.tableView reloadData];
}


@end
