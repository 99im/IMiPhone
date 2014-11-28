//
//  AsyncImageDownloader.h
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTI_ASYNC_IMAGE_DOWNLOADED @"AsyncImageDownloadedNotifiction"

@class AsyncImageDownloader;

@protocol AsyncImageDownloaderDelegate <NSObject>

@optional
- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image object:(NSDictionary *)info;
- (void)imageDownloader:(AsyncImageDownloader *)downloader didFailWithError:(NSError *)error;

@end

@interface AsyncImageDownloader : NSObject

@property (nonatomic, retain) NSOperationQueue *asyncQueue;
@property (nonatomic, retain) id<AsyncImageDownloaderDelegate> delegate;

+ (id)sharedImageDownloader;
- (void)startWithUrl:(NSString *)url delegate:(id<AsyncImageDownloaderDelegate>)aDelegate;

@end
