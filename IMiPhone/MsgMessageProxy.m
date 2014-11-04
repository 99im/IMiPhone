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
- (void)sendHttpSysmsgList:(NSString *)modids before:(long)beforeSmid after:(long)afterSmid start:(long)start pageNum:(NSInteger)pageNum;
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:modids forKey:KEYQ_H__MSG_SYSMSG_LIST__MODIDS];
    [params setObject:[NSNumber numberWithLong:beforeSmid] forKey:KEYQ_H__MSG_SYSMSG_LIST__BEFORESMID];
    [params setObject:[NSNumber numberWithLong:afterSmid] forKey:KEYQ_H__MSG_SYSMSG_LIST__AFTERSMID];
    [params setObject:[NSNumber numberWithLong:start] forKey:KEYQ_H__MSG_SYSMSG_LIST__START];
    [params setObject:[NSNumber numberWithInteger:pageNum] forKey:KEYQ_H__MSG_SYSMSG_LIST__PAGENUM];
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
                     DPSysMessage *dpSysMsg = [DPSysMessage sysMessageByMid:[[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_SMID] longLongValue] withMode:[[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_MODID] integerValue] withType:[[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_TYPE] integerValue] withTime:[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_CTIME] withTitle:[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_TITLE] withContent:[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_CONTENT]];
                     [dpSysMsg setParamsProperty:[msgObj objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_PARAMS]];
                     [arrDpMsgs addObject:dpSysMsg];
                     
                     DPUiMessage *dpUiMessage = [[DPUiMessage alloc] init];
                     dpUiMessage.orderid = [[MsgDataProxy sharedProxy] getUiMsgListNextOrderId];
                     dpUiMessage.type = UI_MESSAGE_TYPE_SYS;
                     dpUiMessage.mid = dpSysMsg.smid;
                     [[MsgDataProxy sharedProxy] updateUiMsgList:dpUiMessage];
                     
                 }
                 [[MsgDataProxy sharedProxy] updateSysMsgList:arrDpMsgs];

                 [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__MSG_SYSMSG_LIST_ object:nil];
             }
             else {
                 [self processErrorCode:errorcode fromSource:PATH_H__MSG_SYSMSG_LIST_ useNotiName:NOTI_H__MSG_SYSMSG_LIST_];
             }
         }
        }
        ];
     };

@end
