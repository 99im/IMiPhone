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
#define GROUP_RELATION_OWNER 1      //创建者
#define GROUP_RELATION_MANAGER 2    //管理员
#define GROUP_RELATION_MEMBER  3    //普通成员
#define GROUP_RELATION_APPLICANT  -3   //申请者 (编码待定)

#define GROUP_STATUS_AUDITING 1  //审核中
#define GROUP_STATUS_AUDITED  0  //已经通过

//群错误码
#define GROUP_ERR_CODE_applied 10036  //已申请过

typedef long long IMGroupId;
typedef long long IMUserId;

@interface DPGroup : NSObject
#pragma mark - 群基信息
@property (nonatomic) IMGroupId gid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger categoryId;             //群分类ID
@property (nonatomic, retain) NSString *categoryName;   //群分类名称
@property (nonatomic) NSInteger memberNum;              //成员数
@property (nonatomic) NSInteger myRelation;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain) NSString *portraitUrl;    //头像地址

#pragma mark - 群主信息
@property (nonatomic) IMUserId creator_uid;
@property (nonatomic, retain) NSString *creator_nick;
@property (nonatomic) IMUserId creator_oid;
@property (nonatomic) NSInteger creator_vip;
@property (nonatomic, retain) NSString *creator_city;

#pragma mark - 群位置信息
@property (nonatomic) double longitude; //经度
@property (nonatomic) double latitude; //纬度
@property (nonatomic) double altitude; //海拔
@property (nonatomic, copy) NSString *address;         //地址
//@property (nonatomic, copy) NSString *countryCode;  // 国家码, eg. CN
//@property (nonatomic, copy) NSString *province;     // 省, eg. 北京

#pragma mark - 状态
@property (nonatomic) NSInteger status; //群状态，状态码待定：0 审核中     1：已审核

#pragma mark - 客户端附加信息
@property (nonatomic) long long localExpireTime;  //本地过期时间，格式(yyyyMMddHHmmss)：201411024125959
//@property (nonatomic) BOOL isInMyGroups;

//-(BOOL)isExpired;
-(BOOL)isGroupOK;           //判断：群是否已通过审核
-(BOOL)isGroupOwner;        //判断：当前用户是否为群主
-(BOOL)isGroupManager;      //判断：当前用户是否为管理员
-(BOOL)isGroupMember;       //判断：当前用户是否为群成员
-(BOOL)isGroupApplicant;    //判断：是否为加群申请者
-(BOOL)canGroupApply;       //判断：判断是否能提交申请
@end
