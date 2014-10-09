//
//  NSNumber+IMNWError.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NSNumber+IMNWError.h"

@implementation NSNumber (IMNWError)

- (NSString *)errorMessage
{
    NSString *sError = @"";

    switch (self.integerValue) {
        case 10016:
            sError = @"verfiy值错误";
            break;
        case 10015:
            sError = @"本次连接已经登录了";
            break;
        case 10014:
            sError = @"不是好友关系，没有权限操作";
            break;
        case 10013:
            sError = @"修改好友用户的备注，长度超过规定值";
            break;
        case 10012:
            sError = @"未登录";
            break;
        case 10011:
            sError = @"目标用户不存在";
            break;
        case 10010:
            sError = @"已经关注过了";
            break;
        case 10009:
            sError = @"没有权限操作";
            break;
        case 10008:
            sError = @"verify 过期需要重新登录";
            break;
        case 10007:
            sError = @"用户名或者密码错误";
            break;
        case 10006:
            sError = @"密码不合法";
            break;
        case 10005:
            sError = @"nick 太长 超出范围";
            break;
        case 10004:
            sError = @"暂时无法响应，请稍后再试";
            break;
        case 10003:
            sError = @"手机号已经被使用";
            break;
        case 10002:
            sError = @"缺少必须的参数（包括get post）";
            break;
        case 0:
            sError = @"正确，没有错误发生";
            break;
        default:
            sError = @"尼玛！未知的错误！！！";
            break;
    }

    return sError;
}

@end