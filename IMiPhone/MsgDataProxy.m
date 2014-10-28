//
//  ChatDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgDataProxy.h"


@interface MsgDataProxy()

@property (nonatomic, retain) NSMutableArray *arrSysMsgs;

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

- (void)updateSysMsgList:(NSArray *)dpMsgList
{
    self.arrSysMsgs = [NSMutableArray array];
    [[SysMessageDAO sharedDAO] deleteByCondition:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
    for (NSInteger i = 0; i < dpMsgList.count; i++)
    {
        DPSysMessage *dpSysMsg = [dpMsgList objectAtIndex:i];
//        NSInteger findIndex = [ImDataUtil getIndexOf:self.arrSysMsgs byItemKey:DB_PRIMARY_KEY_SYS_MSG_SMID withValue:[NSNumber numberWithLong:dpSysMsg.smid]];
//        if (findIndex != NSNotFound) {
//            [self.arrSysMsgs addObject:dpSysMsg];
            DBSysMessage *dbSysMessage = [[DBSysMessage alloc] init];
            [ImDataUtil copyFrom:dpSysMsg To:dbSysMessage];
            [[SysMessageDAO sharedDAO] insert:dbSysMessage];
//        }
    }
}

- (NSArray *)getSysMsgList
{
    if (self.arrSysMsgs == nil)
    {
        NSMutableArray *arrSysMsgs = [[SysMessageDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        self.arrSysMsgs = [NSMutableArray array];
        DPSysMessage *tempSysMessage;
        if (arrSysMsgs) {
            for (NSInteger i = 0; i < arrSysMsgs.count; i++) {
                tempSysMessage = [[DPSysMessage alloc] init];
                [ImDataUtil copyFrom:arrSysMsgs[i] To:tempSysMessage];
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


@end
