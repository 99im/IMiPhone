//
//  UIImageView+ChatImage.m
//  IMiPhone
//
//  Created by yinowl on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UIImageView+ChatImage.h"

@implementation UIImageView (ChatImage)

- (void)setChatImage:(NSString *)url
{
    [self setChatImage:url placeholderImage:nil];
}

- (void)setChatImage:(NSString *)url placeholderImage:(UIImage *)image
{
    self.image = image;
    
    NSString *localPath = [imUtil getCacheImagePath:[url lastPathComponent]];
    UIImage *localImage = [UIImage imageWithContentsOfFile:localPath];
    if (localImage) {
        self.image = localImage;
    }
    else {
        AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
        [downloader startWithUrl:url delegate:self];
    }
}

#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image object:(NSDictionary *)info
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
        NSString *url = [info objectForKey:@"url"];
        [imUtil storeCacheImage:image forName:[url lastPathComponent]];
    });
}

@end
