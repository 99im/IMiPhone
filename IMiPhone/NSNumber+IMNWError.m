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
        case 10039:
            sError = @"没有权限评论";
            break;
        case 10038:
            sError = @"没有权限操作feed";
            break;
        case 10037:
            sError = @"活动不存在或者隐藏了";
            break;
        case 10036:
            sError = @"已经申请过了";
            break;
        case 10035:
            sError = @"已达到创建群数量的上限";
            break;
        case 10034:
            sError = @"活动已经开始，无法离开";
            break;
        case 10033:
            sError = @"活动已经开始了，无法加入 ";
            break;
        case 10032:
            sError = @"活动参加人数达到上限";
            break;
        case 10031:
            sError = @"没有权限对活动进行操作";
            break;
        case 10030:
            sError = @"已经参加活动了";
            break;
        case 10029:
            sError = @"活动归属值错误";
            break;
        case 10028:
            sError = @"相册图片数量达到上限，没有权限再次添加";
            break;
        case 10027:
            sError = @"用户专辑不存在";
            break;
        case 10026:
            sError = @"批准加入群，别的管理员已经拒绝";
            break;
        case 10025:
            sError = @"批准加入群，别的管理员已经同意";
            break;
        case 10024:
            sError = @"加群请求已经过期";
            break;
        case 10023:
            sError = @"已经是群组成员";
            break;
        case 10022:
            sError = @"用户没有权限对群进行操作";
            break;
        case 10021:
            sError = @"群不存在";
            break;
        case 10020:
            sError = @"群名称不符合要求";
            break;
        case 10019:
            sError = @"用户没有权限创建群";
            break;
        case 10018:
            sError = @"加入群达到上限";
            break;
        case 10017:
            sError = @"创建群达到上限";
            break;
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