//
//  IMRichText.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LOCAL_IMAGE_ATTRIBUTE_NAME @"localImageName"

@interface IMRichText : UIView

//支持嵌入图片属性IMAGE_ATTRIBUTE_NAME；渲染结束自适应宽高
+ (IMRichText *)richTextWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth;

//根据本地图片名，组装用于占位的attributedString
+ (NSAttributedString *)assembleLocalImageAbStringByImgName:(NSString *)imgName;

@end
