//
//  ActivityDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPActivity.h"

@interface ActivityDataProxy : NSObject

+ (ActivityDataProxy *)sharedProxy;
- (void)reset;

@end
