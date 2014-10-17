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

@interface TPContactsTableViewController ()

@property (nonatomic, retain) NSMutableArray *arrAddressBookNames;
@property (nonatomic, retain) NSMutableArray *arrAddressBookPhones;

@end

@implementation TPContactsTableViewController

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
    if (section == 0) {
        NSArray *usersFromContact = [[FriendDataProxy sharedProxy] mutableArrayUsersFromContact];
        if (usersFromContact) {
            return usersFromContact.count;
        }
    }
    else if (section == 1)
    {
        return self.arrAddressBookNames.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return nil;//cell;
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
