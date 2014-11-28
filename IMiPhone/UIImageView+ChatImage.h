//
//  UIImageView+ChatImage.h
//  IMiPhone
//
//  Created by yinowl on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageDownloader.h"

@interface UIImageView (ChatImage) <AsyncImageDownloaderDelegate>

- (void)setChatImage:(NSString *)url;
- (void)setChatImage:(NSString *)url placeholderImage:(UIImage *)image;

@end
