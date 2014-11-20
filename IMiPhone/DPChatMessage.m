//
//  DPMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPChatMessage.h"

@implementation DPChatMessage

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

@end
