//
//  RBPeerState.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RBPeerClient;
@class RBVideoCredential;
@class RBVideoAddress;
@class RTCICECandidate;
@class RBVideoPeer;
@class RBTurnServer;


@interface RBPeerState : NSObject

@property (nonatomic,weak) RBPeerClient * mClient;

@property(nonatomic,strong) NSMutableArray * mRemoteCandidates;

@property(nonatomic,strong) NSMutableArray * mIceServers;

@property(nonatomic,assign) int minDeyly;

- (RBPeerState *)bind:(RBVideoAddress *)address;

- (RBPeerState *)free;

- (RBPeerState *)call:(RBVideoPeer *)calleet;

- (RBPeerState *)addCandidate:(RTCICECandidate *)candidate;

- (RBPeerState *)sendCandidate:(RTCICECandidate *)candidate;

-(instancetype)init  __attribute__((
                                    unavailable("init is not a supported initializer for this class.")));

+ (RBPeerState *)create:(RBPeerClient *) client;
@end



@interface RBIdle : RBPeerState

@end




@interface RBPrepare : RBPeerState{
    boolean_t mCallOut;
}

@property(nonatomic,strong) RBVideoPeer * mDest;

@property(nonatomic,strong) RBVideoAddress * address;

@property(nonatomic,strong) RBTurnServer * turnServer;


+ (RBPrepare *)create:(RBPeerClient *) client Address:(RBVideoAddress *)address;

@end



@interface RBStandby : RBPeerState

@property(nonatomic,strong) NSMutableArray * mLocalCandidates;


@end


@interface RBHandshake : RBPeerState
@property(nonatomic,strong) RBVideoPeer * mDest;

+ (RBHandshake *)create:(RBPeerClient *) client State:(RBPeerState *)state VideoPeer:(RBVideoPeer *)dest;

@end


@interface RBConnecting : RBPeerState
+ (RBConnecting *)create:(RBPeerClient *) client PeerState:(RBPeerState *)from;

@end


@interface RBConnected : RBPeerState

@end


@interface RBError : RBPeerState
+ (RBError *)createe:(RBPeerClient *) client ;

@end



@interface RBClosed : RBPeerState
+ (RBError *)createe:(RBPeerClient *) client ;

@end