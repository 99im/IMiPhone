//
//  CommonUserViewController.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPictureTableViewCell.h"
#import "UserInfoTableViewCell.h"
#import "UserDynamiceTableViewCell.h"
#import "UserSignTableViewCell.h"
#import "UserBBSTableViewCell.h"
#import "UserJoinGroupsTableViewCell.h"
#import "UserDescriptionTableViewCell.h"

@interface CommonUserViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
- (IBAction)returnParentInterface:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserNick;
@property (weak, nonatomic) IBOutlet UILabel *lblUserOid;



@end
