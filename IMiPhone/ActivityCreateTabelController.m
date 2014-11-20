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
#import "ActivityCreateTableLabelAndContentCell.h"
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
    ActivityCreateSectionInfoRowEndTimeOrAddress,//活动结束时间或者地址
    ActivityCreateSectionInfoRowAddress//地址
};

#define CREATE_TYPE_GROUP 0
#define CREATE_TYPE_CLUB 1
#define CREATE_TYPE_TEMP 2

@interface ActivityCreateTabelController ()

@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSArray *arrGroups;
@property (nonatomic, retain) NSArray *arrClubs;
@property (nonatomic) BOOL hasChosenEndTime;

@end

@implementation ActivityCreateTabelController

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
    self.hasChosenEndTime = false;
    
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

#pragma - mark tableView

- (NSInteger)numberOfSections
{
    return ActivityCreateSectionNum;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section
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
            if (self.hasChosenEndTime) {
                return ActivityCreateSectionInfoRowAddress + 1;
            }
            else {
                return ActivityCreateSectionInfoRowEndTimeOrAddress + 1;
            }
        case ActivityCreateSectionDetail:
            return 1;
        default:
            NSLog(@"存在非法section!!!");
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
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
        
        if (self.hasChosenEndTime) {
            //多了结束时间一个cell
            if (indexPath.row == ActivityCreateSectionInfoRowEndTimeOrAddress) {
                ActivityCreateTableLabelAndContentCell *lblAndContentCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableLabelAndContentCell" forIndexPath:indexPath];
                return lblAndContentCell;
            }
            else if (indexPath.row == ActivityCreateSectionInfoRowAddress) {
                ActivityCreateTableLabelAndContentCell *lblAndContentAddressCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableLabelAndContentCell" forIndexPath:indexPath];
                return lblAndContentAddressCell;
            }
        }
        else {
            //没有结束时间cell
            //多了结束时间一个cell
            if (indexPath.row == ActivityCreateSectionInfoRowEndTimeOrAddress) {
                ActivityCreateTableLabelAndContentCell *lblAndContentAddressCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableLabelAndContentCell" forIndexPath:indexPath];
//                lblAndContentAddressCell.
                return lblAndContentAddressCell;
            }
        }
    }
    else if (indexPath.section == ActivityCreateSectionDetail) {
        ActivityCreateTableDetailCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"ActivityCreateTableDetailCell" forIndexPath:indexPath];
        //                lblAndContentAddressCell.
        return detailCell;
    }
    
    NSLog(@"ActivityCreateTable 非法的section:%i或者非法的row:%i!!!",indexPath.section,indexPath.row);
    return nil;
}

#pragma deal notification
- (void)registerMessageNotification
{
    
}

- (void)removeMessageNotification
{
    
}


@end
