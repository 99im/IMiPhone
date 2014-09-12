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
- (void)sendTypeRegister:(NSString *)mobcode withPwd:(NSString *)password;
- (void)sendTypeLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password;
- (void)sendTypeMyinfo:(NSString *)verify;
- (void)sendTypeUpdateinfo:(NSNumber *)gender birthday:(NSString *)birth nickname:(NSString *)nick;

@end
