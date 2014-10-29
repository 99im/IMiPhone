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
#import "IMNWMessage.h"
#import "IMNWProxy.h"

#define MARK_USER @"user"

#define RELATION_STRANGER 0
#define RELATION_FOCUS 2
#define RELATION_FAN 3
#define RELATION_FRIEND 1

@interface UserMessageProxy : IMNWProxy

+ (UserMessageProxy *)sharedProxy;

//根据oid（靓号）查找用户
- (void)sendTypeSearch:(NSString *)oid;


@end