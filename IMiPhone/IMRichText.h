//
//  IMRichText.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

/* sample code
 - (void)testC
 {
 IMRichText *rt;
 NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:@"This is a test of characterAttribute. 中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符fdsfsdfsdfsdfsadfsafsafasdfsadfsdafsadfsadfasdfsdfsadfsad222220000001022200233333344444555566666fdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfd1222222220000001022200233333344444555566666fdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdffdasfsdfdf344444555566666"];
 [mabstring beginEditing];
 
 //对同一段字体进行多属性设置
 //红色
 NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
 //斜体
 CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
 [attributes setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
 //下划线
 [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] forKey:(id)kCTUnderlineStyleAttributeName];
 
 [mabstring addAttributes:attributes range:NSMakeRange(0, 4)];
 
 [mabstring addAttributes:[IMRichText getWrapModeAttributes] range:NSMakeRange(0, mabstring.length)];
 NSAttributedString *imgAbStr = [IMRichText assembleLocalImageAbStringByImgName:@"E105" withSize:CGSizeMake(20, 20) withPlaceHolder:@" "];
 [mabstring replaceCharactersInRange:NSMakeRange(43, 1) withAttributedString:imgAbStr];
 imgAbStr = [IMRichText assembleLocalImageAbStringByImgName:@"E106" withSize:CGSizeMake(40, 40) withPlaceHolder:@" "];
 [mabstring replaceCharactersInRange:NSMakeRange(60, 1) withAttributedString:imgAbStr];
 [mabstring endEditing];
 rt = [IMRichText richTextWithAttributedString:mabstring withFrameWidth:150];
 [self.view addSubview:rt];
 }

*/

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#define LOCAL_IMAGE_ATTRIBUTE_NAME @"localImageName"

@interface IMRichText : UIView

@property (nonatomic, retain) NSAttributedString *abString;
@property (nonatomic) CGFloat contentFrameWidth;

//支持嵌入图片属性IMAGE_ATTRIBUTE_NAME；渲染结束自适应宽高
+ (IMRichText *)richTextWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth;

//根据本地图片名，组装用于占位的attributedString
+ (NSAttributedString *)assembleLocalImageAbStringByImgName:(NSString *)imgName withSize:(CGSize)size;

//返回换行模式的熟悉，用于解决图文混排时，图像超出边界
+ (NSDictionary *)getWrapModeAttributes;

//返回richText的frame（注：已自动调整大小）
+ (CGSize)sizeOfRichTextWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth;
@end
