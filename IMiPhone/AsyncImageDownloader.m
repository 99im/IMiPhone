//
//  AsyncImageDownloader.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "AsyncImageDownloader.h"
#import "imUtil.h"

static AsyncImageDownloader *sharedDownloader = nil;

@implementation AsyncImageDownloader

@synthesize delegate = _delegate;
@synthesize asyncQueue = _asyncQueue;

+ (id)sharedImageDownloader
{
    @synchronized(self) {
        if (nil == sharedDownloader) {
            sharedDownloader = [[AsyncImageDownloader alloc] init];
        }
        return sharedDownloader;
    }
}

- (id)init
{
    self = [super init];
    if (nil == sharedDownloader) {
        _asyncQueue = [[NSOperationQueue alloc] init];
        
        sharedDownloader = self;
    }
    
    return sharedDownloader;
}

- (void)startWithUrl:(NSString *)url delegate:(id<AsyncImageDownloaderDelegate>)aDelegate
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:aDelegate, @"delegate", url, @"url", nil];
    [_asyncQueue addOperation:[[NSInvocationOperation alloc]
                               initWithTarget:self selector:@selector(startAsync:) object:info] 
                              ];
}

- (void)startAsync:(NSDictionary *)info
{
    /* 1. Check memory cache */
    /* 2. Check disk cache */
    /* 3. Download the image */
    
    //UIImage *image = nil;
    //image = [cacheQueue tryToHitImageWithKey:[info objectForKey:@"url"]];
    //
    //if (nil != image) {
    //    id theDelegate = [info objectForKey:@"delegate"];
    //    if ([theDelegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:object:)]) {
    //        [theDelegate imageDownloader:self didFinishWithImage:image object:info];
    //    }
    //} else {
        [self performSelector:@selector(downloadImage:) withObject:info];
    //}
}

- (void)downloadImage:(NSDictionary *)info
{
    /* HOWTO: Prevent Downloading the same url many times */
    /* Keep the download task one by one ? */
    
    NSString *url = [info objectForKey:@"url"];
    NSURL *imageUrl = [NSURL URLWithString:url];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    if (image) {
        id theDelegate = [info objectForKey:@"delegate"];
        if ([theDelegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:object:)]) {
            [theDelegate imageDownloader:self didFinishWithImage:image object:info];
        }
        
        [imUtil storeCacheImage:image forName:[url lastPathComponent]];
        //[cacheQueue cacheImage:image withKey:url];
    } else {
#ifdef DEBUG
        NSLog(@"Failed to download : %@\n", url);
#endif
    }
}

@end
