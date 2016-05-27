//
//  RBConsole.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#include <list>
#import "RBConsole.h"
#import "RBComet.h"
#import "RBVideoAddress.h"
#import "RBVideoCredential.h"
#import "RBModleFactory.h"
#import "RBICometEventDelegate.h"
#import "RBLoginModle.h"
#import "RTCLogging.h"

@implementation RBConsole{
    RBVideoAddress      *   urladdress;
    RBVideoCredential   *   credentialinfo;
    NSMutableArray      *   mPendingMessages;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        comet = [[RBComet alloc] init];
        comet.delegate = self;
        modleFactory = [[RBModleFactory alloc] init];
        mIsClose = YES;
        
        mPendingMessages = [NSMutableArray new];
        
        heatbeatTimer = [NSTimer timerWithTimeInterval:30 target:self selector:@selector(sendHeatbeat:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:heatbeatTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)free{
    [comet close];
    urladdress = nil;
    credentialinfo = nil;
    comet.delegate = nil;
    comet = nil;
    mPendingMessages = nil;
    [heatbeatTimer invalidate];
    modleFactory.delegate = nil;
}

- (void) bind:(RBVideoAddress *)address VideoCredential:(RBVideoCredential *)credential{
    urladdress = address;
    credentialinfo = credential;
    [comet connect:address.urlString];
    [modleFactory setLoginParam:credential];
    modleFactory.delegate = self;
}


- (void)sendHeatbeat:(NSTimer *)timer{
    if(_mLoginSucess && !mIsClose){
        [self sendMessage:[modleFactory getHeatbeat]];
    }else{
        [heatbeatTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)sendMessage:(NSString *)msg{
    if(_mLoginSucess){
        [comet sendMessage:msg];
    }else{
        [self addPendingMessages:msg];
    }
}

#pragma mark - Video Connect Message Send

- (void)setAudioEnable:(RBVideoInfoSession *)session AudioEnable:(Boolean)enable{
    [self sendMessage:[modleFactory getMute:session VideoEnable:YES AudioEnable:enable]];
}

- (void)startCall:(RBVideoInfoSession *)session{
    [self sendMessage:[modleFactory getCallModle:session]];
}

- (void)sendBye:(RBVideoInfoSession *)session{
    [self clearPendingMessage];
    [self sendMessage:[modleFactory getBye:session]];
}

- (void)sendOfferSdp:(RBVideoInfoSession *)session SDP:(NSString *)sdp{
    [self sendMessage:[modleFactory getOfferSDP:session SDP:sdp]];
}

- (void)sendAnswerSdp:(RBVideoInfoSession *)session SDP:(NSString *)sdp{
    [self sendMessage:[modleFactory getAnswerSDP:session SDP:sdp]];
}

- (void)sendIceCandidate:(RBVideoInfoSession *)session IceCandidate:(RTCICECandidate *)candidate{
    [self sendMessage:[modleFactory getCandidate:session IceCandidate:candidate]];
}

- (void)callResponse:(RBVideoInfoSession *)session CallState:(CallState)candidate{
    [self sendMessage:[modleFactory getCallResponse:session CallState:candidate]];
}

#pragma mark - PendingMessages

- (void)addPendingMessages:(NSString *)msg{
    if([msg length] > 0)
        [mPendingMessages addObject:msg];
}

- (void)clearPendingMessage{
    [mPendingMessages removeAllObjects];
}

- (void)drainPendingMessages{
    if(_mLoginSucess && !mIsClose){
        for(NSString * msg in mPendingMessages){
            [self sendMessage:msg];
        }
        [self clearPendingMessage];
    }
}

#pragma mark - notifyConsoleEvent

- (void)notifyConsoleEvent:(RBConsoleState )event Code:(int)code Message:(NSString *)msg{
    if(self.cDelegate){
        [self.cDelegate videoConnectState:event ErrorCode:code Reason:msg];
    }
}


#pragma mark - RBCometClient <NSObject>

- (void)onMessage:(NSString*)message{
   
    RBMsgBaseModle * modle = [modleFactory parseModle:message];
    modle.dealDelegate = modleFactory;
    [self sendMessage:[modle dealMessage]];
}

- (void)onOpened{
    mIsClose = NO;
    [comet sendMessage:[modleFactory.loginModle toJSON]];

    [self notifyConsoleEvent:EVENT_CONNECT_OPENED Code:0 Message:@""];
}

- (void)onClose{

    [self onError];
}

- (void)onError{
    mIsClose = YES;
    [comet close];
    _mLoginSucess = NO;
    [self notifyConsoleEvent:EVENT_CONNECT_FAIL Code:0 Message:@""];

}

#pragma mark - RBICometEventDelegate

- (void)onLoginResult:(BOOL)isSucess Event:(VideoEvent)code Reason:(NSString *)reason{
    _mLoginSucess = isSucess;
    if(_mLoginSucess){
        [heatbeatTimer setFireDate:[[NSDate date] dateByAddingTimeInterval:60]];
    }
    [self notifyConsoleEvent:isSucess ? EVENT_CONNECT_LOGIN : EVENT_CONNECT_LOGINFAIL Code:0 Message:reason];
}

- (void)onHeatBeatAck:(BOOL) online{
    _mLoginSucess = online;
    if(!online)
        [self notifyConsoleEvent:EVENT_CONNECT_LOGOUT Code:0 Message:@""];

}


- (void)onVideoControlEvent:(int)event VideoSecssion:(RBVideoInfoSession *)secssion ErrorCode:(VideoEvent)errorcode Reason:(NSObject *)reason{
    if(self.cDelegate){
        [self.cDelegate videoConnectControlEvent:event ErrorCode:errorcode VideoSession:secssion Code:0 Para:reason];
    }
}

- (void)dealloc{
    RTCLog(@"%@ delloc",self);//
}

@end