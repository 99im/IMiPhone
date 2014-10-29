//
//  GroupDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDataProxy.h"

@interface GroupDataProxy()

@property (nonatomic, retain) NSMutableArray *arrGroupMyList;
@property (nonatomic, retain) NSMutableDictionary *dicMessages;

@end

@implementation GroupDataProxy

@synthesize currentGroupId = _currGroupId;
@synthesize arrGroupMyList = _arrGroupMyList;
@synthesize dicMessages = _dicMessages;


static GroupDataProxy *sharedGroupDataProxy = nil;
+ (GroupDataProxy *)sharedProxy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupDataProxy = [[self alloc] init];
    });
    return sharedGroupDataProxy;
}

- (id)init
{
    if((self = [super init]))
    {
        _dicMessages = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSMutableArray *)getGroupMyList {
    if (_arrGroupMyList == nil) {
        //查询数据库
        NSString *where =
        [NSString stringWithFormat:@"%@ > 0", DB_PRIMARY_KEY_GROUP_ID];
        NSString *orderBy =
        [NSString stringWithFormat:@"%@", DB_PRIMARY_KEY_GROUP_ID];
        NSString *limit = [NSString stringWithFormat:@"%i,%i", 0, 10];
        NSMutableArray *result =
        [[GroupDAO sharedDAO] select:where
                             orderBy:orderBy
                               limit:limit
                                bind:[NSMutableArray arrayWithObjects:nil]];

        //处理结果
        _arrGroupMyList = [NSMutableArray array];
        if (result) {
            DPGroup *tempGroup;
            for (NSInteger i = 0; i < result.count; i++) {
                tempGroup = [[DPGroup alloc] init];
                [ImDataUtil copyFrom:result[i] To:tempGroup];
                [_arrGroupMyList addObject:tempGroup];
            }
        }

        //TODO: 距离上次请求时间过长则从服务器拉取
    }
    return [self mutableArrayValueForKey:@"arrGroupMyList"];
}

- (int) updateGroupInfo : (NSDictionary *) info {
    NSLog(@"开始入库保存:群信息\n%@", info);
    return 0;
}
- (int) updateGroupMyList : (NSMutableArray *) list {
    NSLog(@"开始入库保存:我的群组");
    return 0;
}

- (BOOL) isMyGroup : (NSInteger) gid {
    return NO;
}

- (BOOL) isGroupOwner : (NSInteger) creatorUid {
    if ( [UserDataProxy sharedProxy].lastLoginUid == creatorUid ) {
        return YES;
    }
    return NO;
}

- (DPGroup *) getGroupInfoCurrent {
    if (self.currentGroupId > 0) {
        NSLog(@"开始更新群信息：%li" , self.currentGroupId);
        NSString *gid = [NSString stringWithFormat:@"%li" , self.currentGroupId ];
        [[GroupMessageProxy sharedProxy] sendGroupInfo: gid];
    }
    return nil;
}

- (NSMutableArray *)getGroupMessages:(NSInteger)gid
{
    NSNumber *numGid = [NSNumber numberWithInteger:gid];
    if (![_dicMessages objectForKey:numGid]) {
        [_dicMessages setObject:[NSMutableArray array] forKey:numGid];
    }
    return [_dicMessages objectForKey:numGid];
}

@end
