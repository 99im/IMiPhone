//
//  IMRichText.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMRichText.h"
#import <CoreText/CoreText.h>

@interface IMRichText()

@property (nonatomic, retain) NSAttributedString *abString;

@end

@implementation IMRichText

//重写drawRect 是因为在drawRect之前，系统会往栈里面压入一个valid的CGContextRef，否则UIGraphicsGetCurrentContext返回nil
- (void)drawRect:(CGRect)rect
{
    [self testCoreText];
    if (self.abString == nil) {
        NSLog(@"IMRichText drawRect self.abString == nil !!!");
        return;
    }
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.abString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, NULL, self.frame);//self.frame 初始化时候已经计算好
    
    NSLog(@"CGMutablePathRef:%@",path);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetTextMatrix(context , CGAffineTransformIdentity);

    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.frame.size.height);
    
    //当前context lower left 为坐标原点,所以要沿x轴翻转
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(frame,context);

    [self drawLocalImagesWithFrame:frame inContext:context];
    
    CGPathRelease(path);
    CFRelease(framesetter);
    
}

- (void)drawAttributedStringWithFrame:(CTFrameRef)frame inContext:(CGContextRef)context
{
    
}

- (void)drawLocalImagesWithFrame:(CTFrameRef)frame inContext:(CGContextRef)context
{
    
}
//渲染
- (void)testCoreText
{
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    //这四行代码只是简单测试drawRect中context的坐标系
//    CGContextSetRGBFillColor (context, 1, 0, 0, 1);
//    CGContextFillRect (context, CGRectMake (0, 100, 100, 100 ));
//    CGContextSetRGBFillColor (context, 0, 0, 1, .5);
//    CGContextFillRect (context, CGRectMake (220, 200, 50, 200));
//    return;
    
    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:@"This is a test of characterAttribute. 中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符中文字符"];
    [mabstring beginEditing];
    
    //对同一段字体进行多属性设置
    //红色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
    [attributes setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    //下划线
    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    
    [mabstring addAttributes:attributes range:NSMakeRange(0, 4)];
    
    
    NSRange kk = NSMakeRange(0, 4);
    
    NSDictionary * dc = [mabstring attributesAtIndex:0 effectiveRange:&kk];
    
    NSString *embedmageName = @"E106";
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = localImgRunDeleDeallocCallback;
    imageCallbacks.getAscent = localImgRunDeleGetAscentCallback;
    imageCallbacks.getDescent = localImgRunDeleGetDescentCallback;
    imageCallbacks.getWidth = localImgRunDeleGetWidthCallback;
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(embedmageName));
    
    [mabstring addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)(runDelegate) range:NSMakeRange(0,1)];
    [mabstring addAttribute:@"imageName" value:embedmageName range:NSMakeRange(0, 1)];

    [mabstring endEditing];
    
    NSLog(@"value = %@",dc);


    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabstring);
    
    NSLog(@"framesetter:%@",framesetter);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    NSLog(@"CGMutablePathRef:%@",Path);
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, 100, 200));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    NSLog(@"frame:%@",frame);
    
 
    
    if (context == nil) {
        NSLog(@"context == nil!!");
    }
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 10 ,200);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    
    
    CTFrameDraw(frame,context);
    
     [self drawImages:frame withContext:context];
    
    CGPathRelease(Path);
    CFRelease(framesetter);
    
   
    
}


void localImgRunDeleDeallocCallback( void* refCon ){
    NSLog(@"localImgRunDeleDeallocCallback");
}

CGFloat localImgRunDeleGetAscentCallback( void *refCon ){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

CGFloat localImgRunDeleGetDescentCallback(void *refCon)
{
    return 0;
}
CGFloat localImgRunDeleGetWidthCallback(void *refCon)
{
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}

- (void)drawImages:(CTFrameRef)ctFrame withContext:(CGContextRef)context
{
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    //x，y轴方向移动
//    CGContextTranslateCTM(context , 0 ,200);
//    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    int lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    CTLineRef line;
    CGFloat lineAscent;
    CGFloat lineDescent;
    CGFloat lineLeading;
    CFArrayRef runs;
    int runCount;
    
    for (int i = 0; i < lineCount; i++) {
        
        line = CFArrayGetValueAtIndex(lines, i);
        
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        NSLog(@"ascent = %f,descent = %f,leading = %f",lineAscent,lineDescent,lineLeading);
        runs = CTLineGetGlyphRuns(line);

        runCount = CFArrayGetCount(runs);
        
        CGFloat runAscent;
        CGFloat runDescent;
        CGPoint lineOrigin;
        CTRunRef run;
        NSDictionary* attributes;
        CGRect runRect;
        

        for (int j = 0; j < runCount; j++) {
            run = CFArrayGetValueAtIndex(runs, j);
            attributes = (NSDictionary*)CTRunGetAttributes(run);
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            NSLog(@"width = %f",runRect.size.width);
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = image.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y;
                    NSLog(@"imageDrawRect.origin:%f,:%f",imageDrawRect.origin.x,imageDrawRect.origin.y);
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }


        }

    }


}

+ (IMRichText *)richTextWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth
{
    IMRichText *richText = [[IMRichText alloc] initWithAttributedString:abString withFrameWidth:frameWidth];
    return richText;
}

+ (NSAttributedString *)assembleLocalImageAbStringByImgName:(NSString *)imgName
{
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:@" "];
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = localImgRunDeleDeallocCallback;
    imageCallbacks.getAscent = localImgRunDeleGetAscentCallback;
    imageCallbacks.getDescent = localImgRunDeleGetDescentCallback;
    imageCallbacks.getWidth = localImgRunDeleGetWidthCallback;
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(imgName));
    
    NSRange rangeImg = NSMakeRange(0,1);
    [mabString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)(runDelegate) range:rangeImg];
    [mabString addAttribute:LOCAL_IMAGE_ATTRIBUTE_NAME value:imgName range:rangeImg];
    
    return mabString;
}

- (id)initWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth
{
    if (self = [super init]) {
        if (abString == nil) {
            NSLog(@"initWithAttributedString abString == nil!!!");
            abString = [[NSMutableAttributedString alloc] initWithString:@""];
        }
        self.abString = abString;
        CGRect rectBounding = [abString boundingRectWithSize:CGSizeMake(frameWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil];
        self.frame = rectBounding;
    }
    return self;
}

@end
