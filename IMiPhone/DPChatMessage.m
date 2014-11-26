//
//  DPMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPChatMessage.h"
#import "ChatMessageProxy.h"
#import "ChatTextTableViewCell.h"

@implementation DPChatMessage

@synthesize nid;
@synthesize stage;
@synthesize mid;
@synthesize senderUid;
@synthesize targetId;
@synthesize msgType;
@synthesize content;
@synthesize sendTime;
@synthesize gid;

@synthesize imgThumbnail;
@synthesize imgSrc;

@synthesize cellHeight = _cellHeight;

- (void)parseImageContent
{
    if (!imgThumbnail && !imgSrc) {
        NSError *err = nil;
        NSDictionary *imgInfo = [NSJSONSerialization
                                 JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                 options:NSJSONReadingAllowFragments
                                 error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
        } else {
            imgThumbnail = [imgInfo objectForKey:KEYP_S_CHAT_CHAT_CONTENT_THUMBNAIL];
            imgSrc = [imgInfo objectForKey:KEYP_S_CHAT_CHAT_CONTENT_SRC];
        }
    }
}

- (CGFloat)getCellHeight
{
    if (_cellHeight > 0)
        return _cellHeight;
    else
    {
        if (self.msgType == CHAT_MASSAGE_TYPE_TEXT) {
            _cellHeight = [ChatTextTableViewCell heightOfTextCellWithMessage:self.content withFont:[UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE] withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
        }
        else if (self.msgType == CHAT_MASSAGE_TYPE_IMAGE) {
        }

    }
    return _cellHeight;
}

@end
