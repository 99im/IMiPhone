//
//  GroupTableViewCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDataProxy.h"

@interface GroupTableViewCell : UITableViewCell

@property (nonatomic) long long groupId;

@property(nonatomic)  long long userId;

/**
 *  填充单元格数据
 *
 *  @param indexPath 单元格的indexPath值
 */
- (void)fillAtIndexPath:(NSIndexPath *)indexPath;

@end
