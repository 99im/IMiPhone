//
//  DPGroup.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_GROUP_ID @"groupId"

@interface DPGroup : NSObject
#pragma mark - 群基信息
@property (nonatomic) long  gid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger memberNum;  //成员数
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain) NSString *portraitUrl;//头像地址

#pragma mark - 群主信息
@property (nonatomic) long creator_uid;
@property (nonatomic, retain) NSString *creator_nick;
@property (nonatomic) long creator_oid;
@property (nonatomic) long creator_vip;
@property (nonatomic, retain) NSString *creator_city;

#pragma mark - 客户端附加信息
@property (nonatomic) long long localUpdateTime;  //本地存储更新时间，格式：2014110241259

@end
