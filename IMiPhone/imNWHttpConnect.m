//
//  imNWHttpConnect.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imNWHttpConnect.h"
#import "MKNetworkEngine.h"
#import "imNWMessage.h"
#import "imNWManager.h"

@implementation imNWHttpConnect

- (void)sendHttpRequest:(imNWMessage *)message withResponse:(imNWResponseBlock)response
{
    NSMutableDictionary *params = [message getHttpParams];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:message.host];
    MKNetworkOperation *op = nil;
    //不能根据params是否为nil来决定POST还是GET，此处需要修改
    if (params == nil) {
        op = [engine operationWithPath:message.path];
    }
    else {
        op = [engine operationWithPath:message.path params:params httpMethod:@"POST"];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (response) {
            response([completedOperation responseString], [completedOperation responseData]);
        } else {
            [self completionHandler:completedOperation];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self errorHandler:completedOperation error:error];
    }];
    
    [engine enqueueOperation:op];
}

- (void)completionHandler:(MKNetworkOperation *)operation
{
    NSLog(@"Http connect response string: %@", [operation responseString]);
    NSLog(@"Http connect response data: %@", [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:nil];
    imNWMessage *message = [[imNWMessage alloc] init];
    message.data = json;
    message.mark = [json objectForKey:@"mark"];
    message.type = [json objectForKey:@"type"];
    [[imNWManager sharedNWManager] parseMessage:message];
}

- (void)errorHandler:(MKNetworkOperation *)operation error:(NSError *)error
{
    NSLog(@"Http connect error: %@", [error localizedDescription]);
}

@end
