//
//  SysMsgTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPSysMessage.h"

@interface SysMsgTableViewDefaultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

- (void)drawCellBody:(DPSysMessage *)dpSysMsg;

@end
