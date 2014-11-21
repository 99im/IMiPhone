//
//  ChatGraphicsUtil.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/10.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatGraphicsUtil.h"

@implementation ChatGraphicsUtil

+ (IMRichText *)richTextWithMessage:(NSString*)message withFont:(UIFont *)font withContentWidth:(CGFloat) width
{
    NSString *mStr = message;
    NSMutableAttributedString *mAbString = [[NSMutableAttributedString alloc] initWithString:message];
    [mAbString beginEditing];
    NSRange rangeBegin;
    NSRange rangeEnd;
    NSString *subStr;
    NSString *imageId;
    NSAttributedString *imgAbStr;
    
    NSInteger i = 0;
    while (i < mAbString.length) {
        
        subStr = [mStr substringFromIndex:i];//逐渐缩减查找范围
        rangeBegin = [subStr rangeOfString: BEGIN_FLAG];
        if (rangeBegin.length == 0) {
            //断定已经没有表情替代符
            break;
        }
        rangeEnd = [subStr rangeOfString: END_FLAG];
        if (rangeEnd.length == 0) {
            //断定已经没有表情替代符
            break;
        }
        
        imageId = [subStr substringWithRange:NSMakeRange(rangeBegin.location, rangeEnd.location - rangeBegin.location + rangeEnd.length)];//裁出表情替代符
    
        NSString *imageName = [[[ChatDataProxy sharedProxy] getEmotionDic] objectForKey:imageId];
        if (imageName != nil) {
            imgAbStr = [IMRichText assembleLocalImageAbStringByImgName:imageName withSize:CGSizeMake(EMOTION_WIDTH, EMOTION_HEIGHT)];
            [mAbString replaceCharactersInRange:NSMakeRange(i + rangeBegin.location, imageId.length) withAttributedString:imgAbStr];
            mStr = mAbString.string;
            i = i + rangeBegin.location + imgAbStr.length; //rangeBegin之前的区间不会再出现表情替代符

        }
        else {
            i = i + rangeEnd.location + rangeEnd.length;//rangeEnd之前的区间不会再出现表情替代符
        }
    }
    
    //设置字体
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor blackColor].CGColor forKey:(id)kCTForegroundColorAttributeName];

    [attributes setObject:font forKey:(id)kCTFontAttributeName];
    
    //设置换行模式，表情图标出界自动换行
    [attributes setValuesForKeysWithDictionary:[IMRichText getWrapModeAttributes]];
    
    [mAbString addAttributes:attributes range:NSMakeRange(0, mAbString.length)];
    [mAbString endEditing];
    
    return [IMRichText richTextWithAttributedString:mAbString withFrameWidth:width];    
}

@end
