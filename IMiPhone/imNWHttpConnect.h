//
//  imNWHttpConnect.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"

@interface imNWHttpConnect : NSObject

- (void)sendHttpRequest:(imNWMessage *)message;

@end
