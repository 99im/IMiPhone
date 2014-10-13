//
//  imNWProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWMessage.h"

@interface IMNWProxy : NSObject

+ (IMNWProxy*)sharedProxy;

- (void)parseMessage:(IMNWMessage *)message;

@end