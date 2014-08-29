//
//  MarkLogin.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//
//  根据Mark和Type，对应消息的发送和解析方法
//  发送的方法参数可自定义
//  解析的方法格式固定，网络底层会通过反射寻找解析方法
//  "parseType"+TYPE，注意TYPE的大小写
//
//  类名根据模块固定格式"Mark"+MARK，注意MARK的大小写

#import <Foundation/Foundation.h>
#import "imNWMessage.h"

#define MARK_LOGIN @"login"

@interface UserMessageProxy : NSObject

+ (UserMessageProxy*)sharedMark;

- (void)parseMessage:(imNWMessage *)message;

- (void)sendTypeRegister:(NSString *)phone code:(NSString *)code password:(NSString *)password;
- (void)parseTypeRegister:(id)json;

@end