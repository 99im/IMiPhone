//
//  imUtil.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imUtil : NSObject

+ (BOOL)checkPassword:(NSString *)password;

+ (BOOL)checkPhone:(NSString *)phone;

+ (BOOL)checkPoint:(CGPoint)point inRectangle:(CGRect)rect;

+ (BOOL)checkNick:(NSString *)nick;

///计算中英文混排字符串长度，中文按两个字符计算
+ (NSInteger)countStringLength:(NSString *)content;

///检测字符串是否为空，包括nil、NULL、长度为0、长度不为0的whitespace
+ (BOOL)checkBlankString:(NSString *)content;

///清除当前第一响应者的响应状态，放弃第一响应；
+ (void)clearFirstResponder;

//显示提示框，指定时间后自动消失
+ (void)alertViewMessage:(NSString *)msg disappearAfter:(NSTimeInterval)ti;

@end
