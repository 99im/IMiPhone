//
//  imNWHttpConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWHttpConnect.h"
#import "MKNetworkEngine.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "UserDataProxy.h"
#import "NSString+MKNetworkKitAdditions.h"

@implementation IMNWHttpConnect

- (void)sendHttpRequest:(IMNWMessage *)message withResponse:(imNWResponseBlock)response
{
    NSMutableDictionary *params = [message getHttpParams];
    
    if ([message.method isEqualToString:METHOD_POST]) {
        message.path = [NSString stringWithFormat:@"%@?%@=%@", message.path, [HTTP_KEY_VERIFY mk_urlEncodedString], [[UserDataProxy sharedProxy].verify mk_urlEncodedString]];
    }
    
    MKNetworkOperation *op = [self operationWithPath:message.path params:params httpMethod:message.method ssl:message.useSSL];
    
    if (message.multiPartData) {
        id object = nil;
        for (NSString *key in [message.multiPartData allKeys]) {
            object = [message.multiPartData objectForKey:key];
            if ([object isKindOfClass:[NSData class]]) {
                [op addData:object forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]) {
                [op addFile:object forKey:key];
            }
        }
    }
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"Http connect response string: %@", [completedOperation responseString]);
        //NSLog(@"Http connect response data: %@", [[NSString alloc] initWithData:[completedOperation responseData] encoding:NSUTF8StringEncoding]);
        if (response) {
            response([completedOperation responseString], [completedOperation responseData]);
        } else {
            [self completionHandler:completedOperation];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self errorHandler:completedOperation error:error];
    }];
    
    [self enqueueOperation:op];
    NSLog(@"Http connect request: %@", op.url);
    if ([message.method isEqualToString:METHOD_POST]) {
        NSLog(@"Http connect request params: %@", op.readonlyPostDictionary);
    }
}

- (void)completionHandler:(MKNetworkOperation *)operation
{
//    NSLog(@"Http connect response string: %@", [operation responseString]);
//    NSLog(@"Http connect response data: %@", [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:nil];
    IMNWMessage *message = [[IMNWMessage alloc] init];
    message.data = json;
    message.mark = [json objectForKey:@"mark"];
    message.type = [json objectForKey:@"type"];
    [[IMNWManager sharedNWManager] parseMessage:message];
}

- (void)errorHandler:(MKNetworkOperation *)operation error:(NSError *)error
{
    NSLog(@"Http connect error: %@", [error localizedDescription]);
}

@end
