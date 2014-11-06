//
//  ChatDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgDataProxy.h"
#import "ImDataUtil.h"

@interface MsgDataProxy()

@property (nonatomic, retain) NSMutableArray *arrSysMsgs;
@property (nonatomic, retain) NSMutableArray *arrUiMsgs;

@end

@implementation MsgDataProxy



static MsgDataProxy *chatDataProxy = nil;

+ (MsgDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatDataProxy = [[self alloc] init];
    });
    return chatDataProxy;
}

//- (id)init
//{
//    if((self = [super init]))
//    {
//        self.arrSysMsgs = [NSMutableArray array];
//    }
//    return self;
//}

#pragma mark - sysMsgList

- (void)updateSysMsgList:(NSArray *)dpMsgList
{
    self.arrSysMsgs = self.arrSysMsgs;
    [[SysMessageDAO sharedDAO] deleteByCondition:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
    DBSysMessage *dbSysMessage;
    for (NSInteger i = 0; i < dpMsgList.count; i++)
    {
        DPSysMessage *dpSysMsg = [dpMsgList objectAtIndex:i];
//        NSInteger findIndex = [ImDataUtil getIndexOf:self.arrSysMsgs byItemKey:DB_PRIMARY_KEY_SYS_MSG_SMID withValue:[NSNumber numberWithLong:dpSysMsg.smid]];
//        if (findIndex != NSNotFound) {
//            [self.arrSysMsgs addObject:dpSysMsg];
        dbSysMessage = [[DBSysMessage alloc] init];
        dbSysMessage.smid = dpSysMsg.smid;
        dbSysMessage.modid = dpSysMsg.modid;
        dbSysMessage.type = dpSysMsg.type;
        dbSysMessage.ctime = dpSysMsg.ctime;
        dbSysMessage.title = dpSysMsg.title;
        dbSysMessage.content = dpSysMsg.content;
        
//            [ImDataUtil copyFrom:dpSysMsg To:dbSysMessage];
        
        [dbSysMessage setParamsByDictionary:[dpSysMsg getParamsDictionary]];
        
            [[SysMessageDAO sharedDAO] insert:dbSysMessage];
        [self.arrSysMsgs addObject:dpSysMsg];
//        }
    }
}

- (NSArray*)getSysMsgList
{
    if (self.arrSysMsgs == nil) {
        NSMutableArray* arrSysMsgs = [[SysMessageDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        self.arrSysMsgs = [NSMutableArray array];
        DPSysMessage* tempSysMessage;
        DBSysMessage* tempDBSysMessage;
        if (arrSysMsgs) {
            for (NSInteger i = 0; i < arrSysMsgs.count; i++) {
                tempDBSysMessage = [arrSysMsgs objectAtIndex:i];
                tempSysMessage = [DPSysMessage sysMessageByMid:tempDBSysMessage.smid withMode:tempDBSysMessage.modid withType:tempDBSysMessage.type withTime:tempDBSysMessage.ctime withTitle:tempDBSysMessage.title withContent:tempDBSysMessage.content];

                //[ImDataUtil copyFrom:tempDBSsMessage To:tempSysMessage];
                [tempSysMessage setParamsProperty:[tempDBSysMessage getDictionaryByParams]];
                [self.arrSysMsgs addObject:tempSysMessage];
            }
        }
    }
    return self.arrSysMsgs;
}

//- (NSArray *)getMsgListIsNext:(BOOL)isNext beginMid:(long)begin andCount:(NSInteger)count
//{
//    NSMutableArray *arrResult = [NSMutableArray array];
//    
//    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrSysMsgs byItemKey:DB_PRIMARY_KEY_SYS_MSG_SMID withValue:[NSNumber numberWithLong:begin]];
//    if (findIndex == NSNotFound) {
//         NSArray *arrQueryResult;// = [SysMessageDAO sharedDAO] query:<#(NSString *)#> Bind:<#(NSArray *)#>
//    }
//    else {
//        
//    }
//    return arrResult;
//}

- (DPSysMessage *)getSysMsgByMid:(long long)mid
{
    NSArray *sysMsgList = [self getSysMsgList];
    NSInteger findIndex = [ImDataUtil getIndexOf:sysMsgList byItemKey:@"smid" withValue:[NSNumber numberWithLongLong:mid]];
    if (findIndex != NSNotFound) {
        return [sysMsgList objectAtIndex:findIndex];
    }
    return nil;
}

#pragma mark - uiMsgList

- (void)updateUiMsgList:(DPUiMessage *)dpUiMessage
{
    DBUiMessage *dbUiMessage = [[DBUiMessage alloc] init];
    [ImDataUtil copyFrom:dpUiMessage To:dbUiMessage];

    NSArray *uiMsgList = [self getUiMsgList];
    
    if (dpUiMessage.type == UI_MESSAGE_TYPE_CHAT || dpUiMessage.type == UI_MESSAGE_TYPE_GROUP_CHAT ) {
        NSInteger findIndex = [ImDataUtil getIndexOf:uiMsgList byItemKey:@"relationId" withValue:[NSNumber numberWithLongLong:dpUiMessage.relationId]];
        if (findIndex == NSNotFound) {
            [[UiMessageDAO sharedDAO] insert:dbUiMessage];
            [self.arrUiMsgs addObject:dpUiMessage];
            return;
        }
        else {
            DPUiMessage *srcDpUimessage = [self.arrUiMsgs objectAtIndex:findIndex];
            dbUiMessage.orderid  = dpUiMessage.orderid = srcDpUimessage.orderid;
            
            [[UiMessageDAO sharedDAO] update:dbUiMessage ByCondition:[DB_PRIMARY_KEY_UI_MESSAGE_ORDER_ID stringByAppendingString:@"=?"] Bind:[NSArray arrayWithObject:[NSString stringWithFormat:@"%i",dpUiMessage.orderid]]];
            [self.arrUiMsgs replaceObjectAtIndex:findIndex withObject:dpUiMessage];
        }
    }
    else if (dpUiMessage.type == UI_MESSAGE_TYPE_SYS) {
        for (NSInteger i = 0; i < uiMsgList.count; i++) {
            DPUiMessage *tempDpUiMessage = [uiMsgList objectAtIndex:i];
            NSLog(@"dpUiMessage.mid:%lli",dpUiMessage.mid);
            if (dpUiMessage.mid == tempDpUiMessage.mid) {
                NSLog(@"系统消息已经存在！");
                return;
            }
        }
        [[UiMessageDAO sharedDAO] insert:dbUiMessage];
        [self.arrUiMsgs addObject:dpUiMessage];
    }
}

- (NSArray *)getUiMsgList
{
    if (self.arrUiMsgs == nil)
    {
        NSMutableArray *arrDbUiMsgs = [[UiMessageDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        self.arrUiMsgs = [NSMutableArray array];
        DPUiMessage *tempUiMessage;
        if (arrDbUiMsgs) {
            for (NSInteger i = 0; i < arrDbUiMsgs.count; i++) {
                tempUiMessage = [[DPUiMessage alloc] init];
                [ImDataUtil copyFrom:arrDbUiMsgs[i] To:tempUiMessage];
                [self.arrUiMsgs addObject:tempUiMessage];
            }
        }
    }
    return self.arrUiMsgs;
}

- (NSInteger)getUiMsgListNextOrderId
{
    return [self getUiMsgList].count;
}


@end
