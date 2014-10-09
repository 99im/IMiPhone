//
//  AccountMessageProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWProxy.h"

#define MARK_ACCOUNT @"account"

@interface AccountMessageProxy : IMNWProxy

+ (AccountMessageProxy*)sharedProxy;

- (void)sendTypeMobcode:(NSString *)phone withCountry:(NSString *)country;
- (void)sendTypeRegister:(NSString *)password;
- (void)sendHttpLogin:(NSString *)mobile fromCountry:(NSString *)mobCountry withPwd:(NSString *)password;
- (void)sendTypeMyinfo;
- (void)sendTypeUpdateinfo:(NSInteger)gender birthday:(NSString *)birth nickname:(NSString *)nick;

- (void)sendTypeLogin;
- (void)parseTypeLogin:(id)json;

@end
