//
//  RBComet.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBComet.h"
#import "RBWebSocketClient.h"
#import "RTCLogging.h"

@interface RBComet()
@property(nonatomic,strong) RBWebSocketClient * socketCilent;
@end


@implementation RBComet


- (void)setDelegate:(id<RBCometClient>)delegate{
    self.socketCilent.delegate = delegate;
}

-(RBWebSocketClient *)socketCilent{
    if(_socketCilent == nil){
        _socketCilent = [[RBWebSocketClient alloc] init];
        _socketCilent.delegate = _delegate;
    }
    return _socketCilent;
}


- (void)sendMessage:(NSString *)message{
    if(message)
        [self.socketCilent sendMessage:message];
}

- (void)connect:(NSString *)url{
    [self.socketCilent connect:url];
}

- (void)close{
    [self.socketCilent close];
    self.socketCilent = nil;
}


- (void)dealloc{
    RTCLog(@"%@ delloc",self);//
}

@end
