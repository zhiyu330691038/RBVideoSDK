//
//  RBPeerController.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RBPeerState;
@class RBPeerClient;
@class RBVideoAddress;
@class RBVideoPeer;
@class RTCICECandidate;

@interface RBPeerController : NSObject

@property(nonatomic,strong) RBPeerState * mState;
@property(nonatomic,strong) RBPeerClient * mClient;


+ (RBPeerController *)create:(RBPeerClient *)client;

- (RBPeerState *)bind:(RBVideoAddress *)address;

- (RBPeerState *)free;

- (RBPeerState *)call:(RBVideoPeer *)address;

- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate;

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate;

- (void)standby;

- (void)handshake:(RBVideoPeer *)address CallOut:(BOOL)callout;

- (void)onIdle;

- (void)onConnected;

- (void)onConnecting;

- (void)onError:(int) errorCode Msg:(NSString *)msg;

@end
