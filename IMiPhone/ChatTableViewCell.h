//
//  ChatTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatTableViewCellFrame.h"

@interface ChatTableViewCell : UITableViewCell

@property (nonatomic, retain, setter=setCellFrame:) ChatTableViewCellFrame *cellFrame;


@end
