//
//  NSURLConnection+Handle.m
//  JuanRoobo
//
//  Created by Zhi Kuiyu on 15/10/17.
//  Copyright © 2015年 Zhi Kuiyu. All rights reserved.
//

#import "NSURLConnection+Handle.h"

@interface ZYRULconnectionHandle : NSObject{
    NSMutableData * receivedData;

}

@property (nonatomic , strong) void(^commpletionBlock)(NSData *data,NSError *error);

@end


@implementation ZYRULconnectionHandle

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    //修改
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

//添加
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
//    NSLog(@"didReceiveResponse");
    receivedData = [[NSMutableData alloc] init]; // _data being an ivar
//    NSLog(@"receive the response");
    // 注意这里将NSURLResponse对象转换成NSHTTPURLResponse对象才能去
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//    if ([response respondsToSelector:@selector(allHeaderFields)]) {
//        NSDictionary *dictionary = [httpResponse allHeaderFields];
//        NSLog(@"allHeaderFields: %@",dictionary);
//    }
    [receivedData setLength:0];
    
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [receivedData appendData:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    if(_commpletionBlock){
        _commpletionBlock(receivedData,error);
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    if(_commpletionBlock){
        _commpletionBlock(receivedData,nil);
    }
}

@end


@implementation NSURLConnection (Handle)

+ (void)sendAsynchronousRequest:(NSURLRequest *)request
                    completionBlock:(void (^)(NSData *data,
                                              NSError *error))completionHandler{
    __strong ZYRULconnectionHandle * delegate = [[ZYRULconnectionHandle alloc] init];
    
    NSURLConnection* _connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:NO];
    [delegate setCommpletionBlock:^(NSData * data, NSError * error) {
        completionHandler(data,error);
        [_connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }];
    [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_connection start];

}


@end
