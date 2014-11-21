//
//  ActivityCreateTabelController.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityCreateTabelController.h"
#import "GroupDataProxy.h"
#import "ActivityCreateTableDetailCell.h"
#import "ActivityCreateTableInfoCell.h"
#import "ActivityCreateTableLabelDateCell.h"
#import "ActivityCreateTableLimitCell.h"
#import "ActivityCreateTableOptionCell.h"
#import "ActivityCreateTableTitleCell.h"

typedef NS_ENUM(NSInteger, ActivityCreateSection)
{
    ActivityCreateSectionOption = 0,
    ActivityCreateSectionTitle,
    ActivityCreateSectionLimit,
    ActivityCreateSectionInfo,
    ActivityCreateSectionDetail,
    ActivityCreateSectionNum
};

typedef NS_ENUM(NSInteger, ActivityCreateSectionInfoRow)
{
    ActivityCreateSectionInfoRowBase = 0,//花费、女士是否免单、报名人数、活动开始时间
    ActivityCreateSectionInfoRowStartTime,//活动结束时间
    ActivityCreateSectionInfoRowEndTime,//活动结束时间
    ActivityCreateSectionInfoRowAddress,//地址
    ActivityCreateSectionInfoRowNum
};

#define CREATE_TYPE_GROUP 0
#define CREATE_TYPE_CLUB 1
#define CREATE_TYPE_TEMP 2

#define ACTIVITY_CREATE_DATE_PICKER_TAG 99

#define EMBEDDED_DATE_PICKER (DeviceSystemMajorVersion() >= 7)

#define kPickerAnimationDuration    0.40   // duration for the animation to slide the date picker into view


@interface ActivityCreateTabelController ()

@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSArray *arrGroups;
@property (nonatomic, retain) NSArray *arrClubs;
//@property (nonatomic) BOOL hasChosenEndTime;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSIndexPath *datePickerIndexPath;
@property (assign) NSInteger pickerCellRowHeight;

@property (strong, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnItemDone;

@property (nonatomic, retain) UIButton *btnCreate;


@end

@implementation ActivityCreateTabelController

static NSString *kDateCellID = @"ActivityCreateTableLabelDateCell";     // the cells with the start or end date
static NSString *kDatePickerID = @"ActivityCreateTableDatePickerCell"; // the cell containing the date picker


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.type == CREATE_TYPE_GROUP) {
         self.arrGroups = [[GroupDataProxy sharedProxy] getGroupMyList:SEND_HTTP_NO];
    }
    else if(self.type == CREATE_TYPE_CLUB) {
//        self.arrClubs = []
    }
    else if(self.type == CREATE_TYPE_TEMP) {
        
    }
    
    //footerview
    self.btnCreate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnCreate.layer setCornerRadius:5.0];
    self.btnCreate.frame = CGRectMake(10, 10, self.tableView.frame.size.width - 20, 40);
    [self.btnCreate setTitle:NSLocalizedString(@"View.Contact.Friends", null) forState:UIControlStateNormal];
    self.btnCreate.backgroundColor = [UIColor lightGrayColor];
    self.btnCreate.showsTouchWhenHighlighted=YES;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) ];
    [footerView addSubview:self.btnCreate];//必须把按钮添加到一个view上 否则按钮会被拉长
    
    self.tableView.tableFooterView = footerView;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma - mark tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ActivityCreateSectionNum;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case ActivityCreateSectionOption:
            if (self.type == CREATE_TYPE_GROUP) {
                return self.arrGroups.count;
            }
            else if(self.type == CREATE_TYPE_CLUB) {
                return 0;
            }
            else if(self.type == CREATE_TYPE_TEMP) {
                return 1;
            }
            break;
        case ActivityCreateSectionTitle:
            return 1;
        case ActivityCreateSectionLimit:
            return 1;
        case ActivityCreateSectionInfo:
            if ([self hasInlineDatePicker]) {
                return ActivityCreateSectionInfoRowNum + 1;
            }
            return ActivityCreateSectionInfoRowNum;
        case ActivityCreateSectionDetail:
            return 1;
        default:
            NSLog(@"存在非法section!!!");
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ActivityCreateSectionOption) {
        if (self.type == CREATE_TYPE_GROUP) {
            ActivityCreateTableOptionCell *optionCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableOptionCell" forIndexPath:indexPath];
//            [optionCell s]
            return optionCell;
        }
//        else if()
    }
    else if (indexPath.section == ActivityCreateSectionTitle) {
        ActivityCreateTableTitleCell *titleCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableTitleCell" forIndexPath:indexPath];
        //            [optionCell s]
        return titleCell;
    }
    else if (indexPath.section == ActivityCreateSectionLimit) {
        ActivityCreateTableLimitCell *limitCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableLimitCell" forIndexPath:indexPath];
        //            [optionCell s]
        return limitCell;
    }
    else if (indexPath.section == ActivityCreateSectionInfo) {
        if (indexPath.row == ActivityCreateSectionInfoRowBase) {
            ActivityCreateTableInfoCell *infoCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableInfoCell" forIndexPath:indexPath];
            return infoCell;
        }
        else if (indexPath.row == ActivityCreateSectionInfoRowStartTime || indexPath.row == ActivityCreateSectionInfoRowEndTime) {
                ActivityCreateTableLabelDateCell *lblAndContentCell = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerID forIndexPath:indexPath];
                return lblAndContentCell;
        }
        else if (indexPath.row == ActivityCreateSectionInfoRowAddress) {
            ActivityCreateTableLabelDateCell *lblAndContentAddressCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableLabelAndContentCell" forIndexPath:indexPath];
                return lblAndContentAddressCell;
        }
    }
    else if (indexPath.section == ActivityCreateSectionDetail) {
        ActivityCreateTableDetailCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableDetailCell" forIndexPath:indexPath];
        //                lblAndContentAddressCell.
        return detailCell;
    }
    
    NSLog(@"ActivityCreateTable cellForRowAtIndexPath非法的section:%i或者非法的row:%i!!!",indexPath.section,indexPath.row);
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ActivityCreateSectionOption) {
          return 35;
    }
    else if (indexPath.section == ActivityCreateSectionTitle) {
        return 65;
    }
    else if (indexPath.section == ActivityCreateSectionLimit) {
        return 68;
    }
    else if (indexPath.section == ActivityCreateSectionInfo) {
        if (indexPath.row == ActivityCreateSectionInfoRowBase) {
            return 194;
        }
        else {
            return 44;
        }
    }
    else if (indexPath.section == ActivityCreateSectionDetail) {
        return 121;
    }
    NSLog(@"ActivityCreateTable heightForRowAtIndexPath非法的section:%i或者非法的row:%i!!!",indexPath.section,indexPath.row);
    return 0;
}

/*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
 
 @param indexPath The indexPath to reveal the UIDatePicker.
 */
- (void)displayInlineDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = NO;

    BOOL before = NO;   // indicates if the date picker is below "indexPath", help us determine which row to reveal
    if ([self hasInlineDatePicker])
    {
        before = self.datePickerIndexPath.row < indexPath.row;
        sameCellClicked = (self.datePickerIndexPath.row - 1 == indexPath.row);

    }
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:self.datePickerIndexPath.section]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:indexPath.section];
        
        [self toggleDatePickerForSelectedIndexPath:indexPathToReveal];
        self.datePickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:indexPath.section];
    }
    
    // always deselect the row containing the start or end date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    // inform our date picker of the current date to match the current cell
    [self updateDatePicker];
}

/*! Adds or removes a UIDatePicker cell below the given indexPath.

@param indexPath The indexPath to reveal the UIDatePicker.
*/
- (void)toggleDatePickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

/*! Reveals the UIDatePicker as an external slide-in view, iOS 6.1.x and earlier, called by "didSelectRowAtIndexPath".
 
 @param indexPath The indexPath used to display the UIDatePicker.
 */
- (void)displayExternalDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // first update the date picker's date value according to our model
    
    ActivityCreateTableLabelDateCell *cell = (ActivityCreateTableLabelDateCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString * dataStr = cell.textLabel.text;
    NSDate *date = [NSDate dateFromRFC1123:dataStr];
    
    [self.pickerView setDate:date animated:YES];
    
    // the date picker might already be showing, so don't add it to our view
    if (self.pickerView.superview == nil)
    {
        CGRect startFrame = self.pickerView.frame;
        CGRect endFrame = self.pickerView.frame;
        
        // the start position is below the bottom of the visible frame
        startFrame.origin.y = CGRectGetHeight(self.view.frame);
        
        // the end position is slid up by the height of the view
        endFrame.origin.y = startFrame.origin.y - CGRectGetHeight(endFrame);
        
        self.pickerView.frame = startFrame;
        
        [self.view addSubview:self.pickerView];
        
        // animate the date picker into view
        [UIView animateWithDuration:kPickerAnimationDuration animations: ^{ self.pickerView.frame = endFrame; }
                         completion:^(BOOL finished) {
                             // add the "Done" button to the nav bar
                             self.navigationItem.rightBarButtonItem = self.barBtnItemDone;
                         }];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.reuseIdentifier == kDateCellID)
    {
//        if (EMBEDDED_DATE_PICKER)
//            [self displayInlineDatePickerForRowAtIndexPath:indexPath];
//        else
            [self displayExternalDatePickerForRowAtIndexPath:indexPath];
    }
//    else
//    {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
}

#pragma mark - deal notification
- (void)registerMessageNotification
{
    
}

- (void)removeMessageNotification
{
    
}

#pragma - mark - utils

- (BOOL)hasInlineDatePicker
{
    return self.datePickerIndexPath != nil;
}

/*! Determines if the given indexPath has a cell below it with a UIDatePicker.
 
 @param indexPath The indexPath to check if its cell has a UIDatePicker below it.
 */
- (BOOL)hasPickerForIndexPath:(NSIndexPath *)indexPath
{
    BOOL hasDatePicker = NO;
    
    NSInteger targetedRow = indexPath.row;
    targetedRow++;
    
    UITableViewCell *checkDatePickerCell =
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:targetedRow inSection:indexPath.section]];
    UIDatePicker *checkDatePicker = (UIDatePicker *)[checkDatePickerCell viewWithTag:ACTIVITY_CREATE_DATE_PICKER_TAG];
    
    hasDatePicker = (checkDatePicker != nil);
    return hasDatePicker;
}

/*! Updates the UIDatePicker's value to match with the date of the cell above it.
 */
- (void)updateDatePicker
{
    if (self.datePickerIndexPath != nil)
    {
        UITableViewCell *associatedDatePickerCell = [self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        
        UIDatePicker *targetedDatePicker = (UIDatePicker *)[associatedDatePickerCell viewWithTag:ACTIVITY_CREATE_DATE_PICKER_TAG];
        if (targetedDatePicker != nil)
        {
            // we found a UIDatePicker in this cell, so update it's date value
            //
            NSIndexPath *labelDateCellIndexPath = [NSIndexPath indexPathForRow:self.datePickerIndexPath.row - 1 inSection:self.datePickerIndexPath.section];
            ActivityCreateTableLabelDateCell *cell = (ActivityCreateTableLabelDateCell *)[self.tableView cellForRowAtIndexPath:labelDateCellIndexPath];
            
            NSString * dataStr = cell.textLabel.text;
            NSDate *date = [NSDate dateFromRFC1123:dataStr];
            [targetedDatePicker setDate:date animated:NO];
        }
    }
}


@end

