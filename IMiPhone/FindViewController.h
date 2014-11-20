//
//  FindViewController.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDynamicTableViewCell.h"
#import "HavingFunTableViewCell.h"
#import "ServiceTableViewCell.h"
#import "ActivityCellTableViewCell.h"

@interface FindViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic) NSDictionary *dictionary;
@property (nonatomic) NSMutableDictionary *dataFDList;//好友动态字典
@property (nonatomic) NSMutableDictionary *dataHFList;//玩乐字典
@property (nonatomic) NSMutableArray *dataSList;

@end
