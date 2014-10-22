//
//  MsgTableViewCellPrivateChat.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMsgTableViewCellP2P : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end
