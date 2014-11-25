//
//  UserDynamicViewController.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/24.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserD0TableViewCell.h"
#import "UserD1TableViewCell.h"
#import "UserD2TableViewCell.h"
#import "UserD3TableViewCell.h"
#import "UserD4TableViewCell.h"
#import "UserD5TableViewCell.h"
#import "UserD6TableViewCell.h"

@interface UserDynamicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)returnParentInterface:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *imageView;

@end
