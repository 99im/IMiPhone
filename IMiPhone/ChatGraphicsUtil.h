//
//  ChatGraphicsUtil.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/10.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMRichText.h"
#import "ChatDataProxy.h"

#define BEGIN_FLAG @"["
#define END_FLAG @"]"

#define EMOTION_WIDTH  25
#define EMOTION_HEIGHT 25

@interface ChatGraphicsUtil : NSObject

+ (IMRichText *)richTextWithMessage:(NSString*)message withFont:(UIFont *)font withContentWidth:(CGFloat) width;
+ (NSAttributedString *)abStringWithMessage:(NSString*)message withFont:(UIFont *)font;

@end
