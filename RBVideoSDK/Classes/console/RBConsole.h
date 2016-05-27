//
//  RBConsole.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBConsole_h
#define RBConsole_h

#import "RBCometClient.h"
#import <Foundation/Foundation.h>
#import "RBConsoleDelegate.h"
#import "RBICometEventDelegate.h"
#import "RBVideoCallDelegate.h"

@class RBVideoAddress;
@class RBVideoCredential;
@class RBComet;
@class RBModleFactory;
@class RTCICECandidate;
@interface RBConsole : NSObject<RBCometClient,RBICometEventDelegate>{
    RBComet         * comet;
    RBModleFactory  * modleFactory;
    NSTimer         * heatbeatTimer;
    BOOL              mIsClose;
    BOOL              mIsConnected;
}

@property(nonatomic,weak) id<RBConsoleDelegate>  cDelegate;
@property(nonatomic,assign) BOOL mLoginSucess;

- (void)free;

- (void) bind:(RBVideoAddress *)address VideoCredential:(RBVideoCredential *)credential;

- (void)sendMessage:(NSString *)msg;
#pragma mark - Video Connect Message Send
- (void)setAudioEnable:(RBVideoInfoSession *)session AudioEnable:(Boolean)enable;
- (void)startCall:(RBVideoInfoSession *)session;
- (void)sendBye:(RBVideoInfoSession *)session;
- (void)sendOfferSdp:(RBVideoInfoSession *)session SDP:(NSString *)sdp;
- (void)sendAnswerSdp:(RBVideoInfoSession *)session SDP:(NSString *)sdp;
- (void)sendIceCandidate:(RBVideoInfoSession *)session IceCandidate:(RTCICECandidate *)candidate;
- (void)callResponse:(RBVideoInfoSession *)session CallState:(CallState)candidate;
@end

#endif /* RBConsole_h */
