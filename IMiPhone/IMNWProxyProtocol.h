//
//  IMNWProxyProtocol.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMNWProxyProtocol <NSObject>

- (void)registerMessageNotification;
- (void)removeMessageNotification;

@end
