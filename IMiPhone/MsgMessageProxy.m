//
//  MsgMessageProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgMessageProxy.h"
#import "IMNWManager.h"
#import "MsgDataProxy.h"

@implementation MsgMessageProxy

static MsgMessageProxy  *messageProxy = nil;

+ (MsgMessageProxy  *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageProxy = [[self alloc] init];
    });
    return messageProxy;
}

//modids 1 2 3 4
- (void)sendHttpSysmsgList:(NSString *)modids
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    [params setObject: forKey:KEYQ__];
    IMNWMessage *message = [IMNWMessage
                            createForHttp:PATH_H__MSG_SYSMSG_LIST_
                            withParams:params
                            withMethod:METHOD_H__MSG_SYSMSG_LIST_
                            ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
         NSError *err = nil;
         NSMutableDictionary *json = [NSJSONSerialization
                                      JSONObjectWithData:responseData
                                      options:NSJSONReadingAllowFragments
                                      error:&err];
         if (err) {
             NSAssert1(YES, @"JSON create error: %@", err);
         } else {
             
             int errorcode = [
                              [json objectForKey:KEYP_H__MSG_SYSMSG_LIST__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSMutableArray *arrDpMsgs = [NSMutableArray array];
                 NSArray *arrMsglist = [json objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST];
                 for (NSInteger i = 0; i < arrMsglist.count; i++) {
                     NSDictionary *msgObj = [arrMsglist objectAtIndex:i];
                     DPSysMessage *dpSysMsg = [[DPSysMessage alloc] init];
                     dpSysMsg.uid = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_UID] longValue];
                     dpSysMsg.smid = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_SMID] longValue];
                     dpSysMsg.modid = [msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_MODID];
                     dpSysMsg.type = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_TYPE] integerValue];
                     dpSysMsg.ctime = [msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_CTIME];
                     dpSysMsg.targetId = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_TARGETID] longValue];
                     dpSysMsg.extraId = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_EXTRAID] longValue];
                     dpSysMsg.content = [msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_UID];
                     dpSysMsg.resultStatus = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_RESULTSTATUS] integerValue];
                     dpSysMsg.extraStatus = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_EXTRASTATUS] integerValue];
                     dpSysMsg.unread = [[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_UID] integerValue];
                     [arrDpMsgs addObject:dpSysMsg];
                 }
                 [[MsgDataProxy sharedProxy] updateSysMsgList:arrDpMsgs];

                 [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__MSG_SYSMSG_LIST_ object:nil];
             }
             else {
                 NSError *error = [self processErrorCode:errorcode fromSource:PATH_H__MSG_SYSMSG_LIST_];
                 

             }
         }
        }
        ];
     };

@end
