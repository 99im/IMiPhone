//
//  AccountMessageProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWProxy.h"

#define MARK_ACCOUNT @"account"

@interface AccountMessageProxy : imNWProxy

+ (AccountMessageProxy*)sharedProxy;

- (void)sendTypeMobcode:(NSString *)phone withCountry:(NSString *)country;

@end
