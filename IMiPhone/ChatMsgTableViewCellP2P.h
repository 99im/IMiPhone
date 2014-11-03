//
//  ChatMsgTableViewCellP2P.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPChatMessage.h"

@interface ChatMsgTableViewCellP2P : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLastMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (void)drawCellBody:(DPChatMessage *)dpChatMsg;

@end
