//
//  imNWProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"

@interface imNWProxy : NSObject

+ (imNWProxy*)sharedProxy;

- (void)parseMessage:(imNWMessage *)message;

@end
