//
//  DPGroup.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define DB_PRIMARY_KEY_GROUP_ID @"groupId"

//群关系：
#define GROUP_RELATION_NONE 0       //无关系
#define GROUP_RELATION_OWNER 1    //创建者
#define GROUP_RELATION_MANAGER 2    //管理员
#define GROUP_RELATION_MEMBER  3    //普通成员

@interface DPGroup : NSObject
#pragma mark - 群基信息
@property (nonatomic) long long gid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger memberNum;  //成员数
@property (nonatomic) NSInteger myRelation;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain) NSString *portraitUrl;//头像地址

#pragma mark - 群主信息
@property (nonatomic) long long creator_uid;
@property (nonatomic, retain) NSString *creator_nick;
@property (nonatomic) long long creator_oid;
@property (nonatomic) NSInteger creator_vip;
@property (nonatomic, retain) NSString *creator_city;

#pragma mark - 客户端附加信息
@property (nonatomic) long long localExpireTime;  //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959
//@property (nonatomic) BOOL isInMyGroups;
@end
