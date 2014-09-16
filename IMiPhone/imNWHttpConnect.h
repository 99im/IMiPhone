//
//  imNWHttpConnect.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"
#import "MKNetworkKit/MKNetworkOperation.h"
#import "MKNetworkEngine.h"

typedef void (^imNWResponseBlock)(NSString* responseString, NSData* responseData);

@interface imNWHttpConnect : MKNetworkEngine

- (void)sendHttpRequest:(imNWMessage *)message withResponse:(imNWResponseBlock)response;

@end
