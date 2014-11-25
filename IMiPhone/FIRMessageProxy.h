//
//  FIRMessageProxy.h
//  IMiPhone
//
//  Created by yinowl on 14/11/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"

@interface FIRMessageProxy : IMNWProxy

+ (FIRMessageProxy *)sharedProxy;

- (void)sendHttpVersion;

@end
