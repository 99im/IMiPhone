//
//  AddTableViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AddTableViewController.h"
#import "AddByInputTVCell.h"

@interface AddTableViewController ()

@property (nonatomic, retain) NSArray *arrTPs;

@end

@implementation AddTableViewController

const int sectionInput = 0;
const int sectionTP = 1;
const int sectionNum = 2;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case sectionInput:
        {
            AddByInputTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addByInputCell" forIndexPath:indexPath];
            if (indexPath.row == 0) {
                cell.tfAddTarget.placeholder = NSLocalizedString(@"Contact.Add.UserID", nil);
            }
            else if (indexPath.row == 1)
            {
                cell.tfAddTarget.placeholder = NSLocalizedString(@"Contact.Add.GroupID", nil);
            }
            return cell;
        }
        case sectionTP:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addByTPCell" forIndexPath:indexPath];
            cell.textLabel.text = [self.arrTPs objectAtIndex:indexPath.row];
            return cell;
        }
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return nil;
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

@end
