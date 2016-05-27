//
//  RBPeerState.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBPeerState.h"
#import "RBPeerClient.h"

#import "RBPeerClient.h"
#import "RBVideoCredential.h"
#import "RBVideoAddress.h"
#import "RTCICECandidate.h"
#import "RBVideoPeer.h"
#import "RBTurnServer.h"

static int Max_Delay = 60;

@implementation RBPeerState
- (RBPeerState *)bind:(RBVideoAddress *)address{
    return self;
}

- (RBPeerState *)free{
    return self;
}

- (RBPeerState *)call:(RBVideoPeer *)calleet{
    return self;
}



- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate{
    return self;
}

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate{
    return self;
}

+ (RBPeerState *)create:(RBPeerClient *) client{
    RBPeerState * state = [[[self class] alloc] init];
    state.mClient = client;
    state.minDeyly = 1;
    return state;
}
@end


@implementation RBIdle

- (RBPeerState *)bind:(RBVideoAddress *)address{


    return [RBPrepare create:self.mClient Address:address];
}


@end


@implementation RBPrepare
+ (RBPrepare *)create:(RBPeerClient *) client Address:(RBVideoAddress *)address{

    RBPrepare * pre = (RBPrepare *)[RBPrepare create:client];
    pre.address = address;
    pre.turnServer = [RBTurnServer create:address.urlString];
   
    [pre prepare];
    
    return pre;
}


- (void)prepare{
    __block RBPrepare * weakSelf = self;
    
    [self.turnServer connect:^(NSArray *turnServers, NSError *error) {
        weakSelf.mIceServers = [NSMutableArray arrayWithArray:turnServers];
        if(![weakSelf.mIceServers isKindOfClass:[NSArray class]] || weakSelf.mIceServers.count == 0){
            weakSelf.minDeyly = MIN(weakSelf.minDeyly * 2, Max_Delay);
            [weakSelf performSelector:@selector(prepare) withObject:nil afterDelay:weakSelf.minDeyly];
        }else{
            [weakSelf.mClient preparePeerConnection:turnServers];
            if(weakSelf.mDest != nil){
                [weakSelf.mClient.mController handshake:weakSelf.mDest CallOut:YES];
            }else{
                [weakSelf.mClient.mController standby];
            }
        }
    }];
}


- (RBPeerState *)call:(RBVideoPeer *)calleet{
    self.mDest = calleet;
    return self;
}



-(RBPeerState *)free{
    self.mIceServers = nil;
    return self;
}

@end



@implementation RBStandby

- (RBPeerState *)call:(RBVideoPeer *)calleet{

    return [RBHandshake create:self.mClient State:self VideoPeer:calleet];
}

-(RBPeerState *)sendCandidate:(RTCICECandidate *)candidate{
    if(candidate != nil){
        if(self.mLocalCandidates == nil){
            self.mLocalCandidates = [NSMutableArray new];
        }
        [self.mLocalCandidates addObject:candidate];
    }
    return self;

}

@end






@implementation RBHandshake
- (void)sendPostCandidates:(RBPeerState *)state{
    if([state isKindOfClass:[RBStandby class]]){
        RBStandby * sy = (RBStandby *)state;
        if(sy.mLocalCandidates.count > 0){
            [self.mClient sendCandidates:sy.mLocalCandidates];
        }
        
    }
    
}

- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate{
    if(candidate != nil){
        if(self.mRemoteCandidates == nil){
            self.mRemoteCandidates = [NSMutableArray new];
        }
        [self.mRemoteCandidates addObject:candidate];
    }
    return self;
}

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate{
    if(candidate)
        [self.mClient sendCandidates:@[candidate]];
    return self;
}

+ (RBHandshake *)create:(RBPeerClient *) client State:(RBPeerState *)state VideoPeer:(RBVideoPeer *)dest{
    RBHandshake * sta = (RBHandshake *)[RBHandshake create:client];
    sta.mDest = dest;
    [sta.mClient handleCall:dest];
    [sta sendPostCandidates:state];
    return sta;
}


@end


@implementation RBConnecting
+ (RBConnecting *)create:(RBPeerClient *) client PeerState:(RBPeerState *)from{
    RBConnecting * sta = (RBConnecting *)[RBConnecting create:client];
    if([from isKindOfClass:[RBHandshake class]]){
        RBHandshake *hs = (RBHandshake *)from;
        if(hs.mRemoteCandidates.count > 0){
            [sta.mClient addCandidatess:hs.mRemoteCandidates];
        }
    }
    return sta;
}

- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate{
    if(candidate != nil){
        [self.mClient addCandidatess:@[candidate]];
    }
    return self;
}

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate{
    if(candidate)
        [self.mClient sendCandidates:@[candidate]];
    return self;
}
@end


@implementation RBConnected



@end


@implementation RBError

+ (RBError *)createe:(RBPeerClient *) client {
    RBError * sta = (RBError *)[RBError create:client];
    [sta.mClient resetConnection];
    return sta;
}

@end


@implementation RBClosed
+ (RBClosed *)createe:(RBPeerClient *) client {
    RBClosed * sta = (RBClosed *)[RBClosed create:client];
    [sta.mClient resetConnection];
    return sta;
}



@end
