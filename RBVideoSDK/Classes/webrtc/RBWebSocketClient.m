//
//  RBWebSocketClient.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBWebSocketClient.h"
#import <arpa/inet.h>

@implementation RBWebSocketClient


- (void)bind{
    
    if(_webSocket != nil){
        _webSocket.delegate = nil;
        [_webSocket close];
        _webSocket = nil;
    }
    _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:_socketURL]];
    _webSocket.delegate = self;
    [_webSocket open];

}

- (void)sendMessage:(NSString *)message{
    [_webSocket send:message];
    NSLog(@"send message %@", message);


}

- (void)connect:(NSString *)url{

    
    NSString *hostname = @"v3.roo.bo";
    CFHostRef hostRef = CFHostCreateWithName(kCFAllocatorDefault, (__bridge CFStringRef)hostname);
    if (hostRef)
    {
        Boolean result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
        if (result == TRUE)
        {
            NSArray *addresses = (__bridge NSArray*)CFHostGetAddressing(hostRef, &result);
            
            NSMutableArray *tempDNS = [[NSMutableArray alloc] init];
            for(int i = 0; i < addresses.count; i++)
            {
                struct sockaddr_in* remoteAddr;
                CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex((__bridge CFArrayRef)addresses, i);
                remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
                
                if(remoteAddr != NULL)
                {
                    const char *strIP41 = inet_ntoa(remoteAddr->sin_addr);
                    
                    NSString *strDNS =[NSString stringWithCString:strIP41 encoding:NSASCIIStringEncoding];
                    NSLog(@"RESOLVED %d:<%@>", i, strDNS);
                    [tempDNS addObject:strDNS];
                }
            }
        }
    }
    _socketURL = url;
    if(_socketURL == nil){
        if(_delegate && [_delegate respondsToSelector:@selector(onError)]){
            [_delegate onError];
        }
        return;
    }
    [self bind];
}

- (void)close{
    _socketURL = nil;
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
    _delegate = nil;
}


#pragma mark - SRWebSocketDelegate

// message will either be an NSString if the server is using text
// or NSData if the server is using binary.
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"recored message %@", message);
    if(_delegate && [_delegate respondsToSelector:@selector(onMessage:)]){
        [_delegate onMessage:message];
    }

}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    if(_delegate && [_delegate respondsToSelector:@selector(onOpened)]){
        [_delegate onOpened];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    if(_delegate && [_delegate respondsToSelector:@selector(onError)]){
        [_delegate onError];
    }

}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    if(_delegate && [_delegate respondsToSelector:@selector(onClose)]){
        [_delegate onClose];
    }

}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{


}

@end
