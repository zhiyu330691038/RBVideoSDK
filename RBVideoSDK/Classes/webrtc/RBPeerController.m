//
//  RBPeerController.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBPeerController.h"
#import "RBPeerState.h"
#import "RBPeerClient.h"
#import "RBVideoAddress.h"
#import "RBVideoPeer.h"
#import "RTCICECandidate.h"
#import "RTCLogging.h"
@implementation RBPeerController
+ (RBPeerController *)create:(RBPeerClient *)client{
    RBPeerController * con = [[RBPeerController alloc] init];
    con.mClient = client;
    return con;
}

- (RBPeerState *)bind:(RBVideoAddress *)address{
    if(self.mState != nil){
        self.mState = [self.mState bind:address];
    }
    return _mState;
}

- (RBPeerState *)free{
    if(self.mState != nil){
        _mState = [_mState free];
    }
    return _mState;
}

- (RBPeerState *)call:(RBVideoPeer *)address{
    if(_mState != nil){
        _mState = [_mState call:address];
    }
    return _mState;
}


- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate{
    if(_mState != nil){
        _mState = [_mState addCandidate:candidate];
    }
    return _mState;
}

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate{
    if(_mState != nil){
        _mState = [_mState sendCandidate:candidate];
    }
    return _mState;
}

- (void)standby{
    self.mState = [RBStandby create:self.mClient];
}

- (void)handshake:(RBVideoPeer *)address CallOut:(BOOL)callout{
    self.mState = [RBHandshake create:self.mClient State:self.mState VideoPeer:address];

}

- (void)onIdle{
    self.mState = [RBIdle create:self.mClient];
}

- (void)onConnected{
    self.mState = [RBConnected create:self.mClient];
}

- (void)onConnecting{
    self.mState = [RBConnecting create:self.mClient PeerState:self.mState];

}

- (void)onError:(int) errorCode Msg:(NSString *)msg{
    self.mState = [RBError createe:self.mClient];
}


- (void)dealloc{
    RTCLog(@"dealloc %@",self);//
}
@end
