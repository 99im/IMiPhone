//
//  imNWProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWMessage.h"
#import "NSNumber+IMNWError.h"

@interface IMNWProxy : NSObject

+ (IMNWProxy*)sharedProxy;

- (void)parseMessage:(IMNWMessage *)message;

/**
 *  消息错误码通用处理方法
 *
 *  @param errorcode 错误码，http消息的errorcode或者socket消息的res
 *  @param source    来源，path或者mark＋type
 *
 *  @return 错误类型实例
 */
- (NSError *)processErrorCode:(NSInteger)errorcode fromSource:(NSString *)source;

@end
