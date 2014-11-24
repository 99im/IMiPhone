//
//  AllGroupTableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDataProxy.h"
#import "DPGroup.h"

@interface AllGroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupIntroduce;

@property (nonatomic) IMGroupId groupId;


//实现方法
- (void) paddingDataForCell:(NSIndexPath *)indexPath;
@end
