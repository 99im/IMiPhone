//
//  AllGroupViewController.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGroupTableViewCell.h"

@interface AllGroupViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//数据存储
@property (strong, nonatomic) NSMutableArray *nearbyGroupList;
@property (strong, nonatomic) NSMutableArray *nearbyGroupRecruitList;

//当前使用数据
@property (nonatomic, retain) NSArray *nowGroupList;

//设置当前显示数据
- (void) settingNowGroupList:(NSInteger) tag;
@end
