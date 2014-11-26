//
//  UserJoinGroupsTableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinGroupTableViewCell.h"

@interface UserJoinGroupsTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
