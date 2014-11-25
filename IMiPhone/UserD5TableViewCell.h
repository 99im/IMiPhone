//
//  UserD5TableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinGroupCellTableViewCell.h"

@interface UserD5TableViewCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
