//
//  ChatImageTableViewCell.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/11/20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatTableViewCell.h"

#define CHAT_CELL_CONTENT_IMAGE_HEIGHT 80.0f

@interface ChatImageTableViewCell : ChatTableViewCell

//预先计算cell高度
+ (CGFloat)heightOfCell;

@end
