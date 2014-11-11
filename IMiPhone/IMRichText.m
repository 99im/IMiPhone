//
//  IMRichText.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMRichText.h"

#define RUN_CALLBACK_PARAM_KEY_IMAGE_NAME @"name"
#define RUN_CALLBACK_PARAM_KEY_IMAGE_WIDTH @"width"
#define RUN_CALLBACK_PARAM_KEY_IMAGE_HEIGHT @"height"

@interface IMRichText()

@property (nonatomic) CGFloat contentFrameAutoSizeHeight;
@property (nonatomic) CGFloat contentFrameAutoSizeWidth;
@property (nonatomic, retain) NSMutableArray *arrRunParams;

@end

@implementation IMRichText

@synthesize abString = _abString;
@synthesize contentFrameWidth = _contentFrameWidth;
@synthesize arrRunParams = _arrRunParams;

static NSMutableArray *arrRunParams;//用于保存所用run的参数，否则莫名被释放掉。在run的dealloc回调里再移除掉


+ (IMRichText *)richTextWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth
{
    IMRichText *richText = [[IMRichText alloc] initWithAttributedString:abString withFrameWidth:frameWidth];
    return richText;
}

+ (NSAttributedString *)assembleLocalImageAbStringByImgName:(NSString *)imgName withSize:(CGSize)size
{
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:@" "];
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = localImgRunDeleDeallocCallback;
    imageCallbacks.getAscent = localImgRunDeleGetAscentCallback;
    imageCallbacks.getDescent = localImgRunDeleGetDescentCallback;
    imageCallbacks.getWidth = localImgRunDeleGetWidthCallback;

    
    NSDictionary *dicParams = [NSDictionary dictionaryWithObjectsAndKeys:imgName, RUN_CALLBACK_PARAM_KEY_IMAGE_NAME, [NSNumber numberWithDouble:size.width] , RUN_CALLBACK_PARAM_KEY_IMAGE_WIDTH, [NSNumber numberWithDouble:size.height], RUN_CALLBACK_PARAM_KEY_IMAGE_HEIGHT, nil];
    if (arrRunParams == nil){
        arrRunParams = [NSMutableArray array];
    }
    [arrRunParams addObject:dicParams];
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(dicParams));
    
    NSRange rangeImg = NSMakeRange(0,mabString.length);
    [mabString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)(runDelegate) range:rangeImg];
    [mabString addAttribute:LOCAL_IMAGE_ATTRIBUTE_NAME value:imgName range:rangeImg];
    
    return mabString;
}

// 获得换行模式属性
+ (NSDictionary *)getWrapModeAttributes
{
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName ];
    return attributes;
}

- (void)setAbString:(NSAttributedString *)abString
{
    _abString = abString;
    [self initFrame];
    [self setNeedsDisplay];
}

- (void)setContentFrameWidth:(CGFloat)frameWidth
{
    _contentFrameWidth = frameWidth;
    [self initFrame];
    [self setNeedsDisplay];
}

//重写drawRect 是因为在drawRect之前，系统会往栈里面压入一个valid的CGContextRef，否则UIGraphicsGetCurrentContext返回nil
- (void)drawRect:(CGRect)rect
{
    if (_abString == nil) {
        NSLog(@"IMRichText drawRect _abString == nil !!!");
        return;
    }
    if (_contentFrameWidth == 0) {
        NSLog(@"IMRichText drawRect _frameWidth == 0!!!");
        return;
    }
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_abString);

    CGMutablePathRef path = CGPathCreateMutable();
    CGRect pathRect = CGRectMake(0, 0, self.contentFrameAutoSizeWidth, self.contentFrameAutoSizeHeight);
    CGPathAddRect(path, NULL, pathRect);
    NSLog(@"CGMutablePathRef:%@",path);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetTextMatrix(context , CGAffineTransformIdentity);

    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
        //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.contentFrameAutoSizeHeight);
    
    //当前context lower left 为坐标原点,所以要沿x轴翻转
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(frame, context);
    
    
    CGPathRelease(path);
    //绘制内嵌图片
    CFArrayRef lines = CTFrameGetLines(frame);
    int lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);

    [self drawLocalImagesWithFrame:frame inContext:context];
    
    CGContextRestoreGState(context);

}

- (void)drawLocalImagesWithFrame:(CTFrameRef)ctFrame inContext:(CGContextRef)context
{
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
        CGPoint lineOrigin = lineOrigins[i];//baseline 起始点的坐标
        CTRunRef run;
        NSDictionary* attributes;
        CGRect runRect;
        
        for (int j = 0; j < runCount; j++) {
            run = CFArrayGetValueAtIndex(runs, j);
            attributes = (NSDictionary*)CTRunGetAttributes(run);
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            NSLog(@"width = %f",runRect.size.width);
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            NSString *imageName = [attributes objectForKey:LOCAL_IMAGE_ATTRIBUTE_NAME];
            //图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = runRect.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y;
//                    NSLog(@"imageDrawRect.origin:%f,:%f",imageDrawRect.origin.x,imageDrawRect.origin.y);
                    
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
        
    }
}

static void localImgRunDeleDeallocCallback( void* refCon ){
    NSLog(@"localImgRunDeleDeallocCallback");
    [arrRunParams removeObject:(__bridge id)(refCon)];
}

static CGFloat localImgRunDeleGetAscentCallback( void *refCon ){
//    NSLog(@"localImgRunDeleGetAscentCallback refCon:%@", (__bridge NSDictionary *)refCon);
//    return 0;
    CFDictionaryRef dicParams = refCon;
    NSString *imageName = CFDictionaryGetValue(dicParams, RUN_CALLBACK_PARAM_KEY_IMAGE_NAME);
    NSNumber *numHeight = CFDictionaryGetValue(dicParams, RUN_CALLBACK_PARAM_KEY_IMAGE_HEIGHT);
    CGFloat height = [numHeight doubleValue];
    if (height == 0) {//未指定图片高度，图片显示原本高度
        height = [UIImage imageNamed:imageName].size.height;
    }
    return height;
}

static CGFloat localImgRunDeleGetDescentCallback(void *refCon)
{
    NSLog(@"localImgRunDeleGetDescentCallback refCon:%@", refCon);

    return 0;
}
static CGFloat localImgRunDeleGetWidthCallback(void *refCon)
{
//    NSLog(@"localImgRunDeleGetWidthCallback refCon:%@", refCon);
//    return 0;
    CFDictionaryRef dicParams = refCon;
    NSString *imageName = CFDictionaryGetValue(dicParams, RUN_CALLBACK_PARAM_KEY_IMAGE_NAME);
    NSNumber *numWidth = CFDictionaryGetValue(dicParams, RUN_CALLBACK_PARAM_KEY_IMAGE_WIDTH);
    CGFloat width = [numWidth doubleValue];
    if (width == 0) {//未指定图片高度，图片显示原本高度
        width = [UIImage imageNamed:imageName].size.width;
    }
    return width;
}
//M80AttributedLabelAttachment* attributedImage = (M80AttributedLabelAttachment *)CTRunDelegateGetRefCon(delegate);获得run中的图片信息

- (IMRichText *)initWithAttributedString:(NSAttributedString *)abString withFrameWidth:(CGFloat)frameWidth
{
    if (self = [super init]) {
        _abString = abString;
        _contentFrameWidth = frameWidth;
        [self initFrame];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)initFrame
{
    if (_abString == nil) {
        NSLog(@"initFrame abString == nil!!!");
        return;
    }
    if (_contentFrameWidth == 0) {
        NSLog(@"initFrame _frameWidth == 0!!!");
        return;
    }
   
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_abString);
    
//    CGSizeMake(CGFLOAT_MAX, <#CGFloat height#>)
    
    CGSize noConstraintsSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize fitSizeOfNoConstraints = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, noConstraintsSize, NULL);
    if (fitSizeOfNoConstraints.width < _contentFrameWidth) {
        
        self.contentFrameAutoSizeWidth = fitSizeOfNoConstraints.width;
        self.contentFrameAutoSizeHeight = fitSizeOfNoConstraints.height;
    }
    else {
        
        self.contentFrameAutoSizeWidth = _contentFrameWidth;

        CGSize widthConstraintsSize = CGSizeMake(_contentFrameWidth, CGFLOAT_MAX);

        CGSize fitSizeOfWidthConstraints = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, widthConstraintsSize, NULL);
        
        self.contentFrameAutoSizeHeight = fitSizeOfWidthConstraints.height;
    }

    CFRelease(framesetter);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.contentFrameAutoSizeWidth, self.contentFrameAutoSizeHeight);
}

@end
