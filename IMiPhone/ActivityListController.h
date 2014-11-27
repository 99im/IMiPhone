//
//  ActivityListController.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityDataProxy.h"
#import "IMNWProxyProtocol.h"
#import "ActivityListTableViewCell.h"

@interface ActivityListController : UIViewController <UITableViewDataSource, UITableViewDelegate, IMNWProxyProtocol>

@end
