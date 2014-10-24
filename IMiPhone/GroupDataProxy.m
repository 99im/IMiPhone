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

@end

@implementation GroupDataProxy

@synthesize arrGroupMyList = _arrGroupMyList;

- (NSMutableArray *)sendGroupMyList {
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
  }
  return [self mutableArrayValueForKey:@"arrGroupMyList"];
}

@end
