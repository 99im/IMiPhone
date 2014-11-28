//
//  NearbyTableViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationDataProxy.h"
#import "NearbyVipTableViewCell.h"
#import "NearbyBabyTableViewCell.h"
#import "NearbyStarTableViewCell.h"
#import "NearbyAngleTableViewCell.h"
#import "NearbyClubManagerTableViewCell.h"
#import "NearbyClubTableViewCell.h"
#import "NearbyGroupRecruitTableViewCell.h"
#import "DiscoveryDataProxy.h"
#import "DiscoveryMessageProxy.h"
#import "DPUser.h"
#import "DPNearbyClub.h"
#import "ClubDataProxy.h"
#import "UserShowViewController.h"

@interface NearbyTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end
