//
//  RBPeerClient.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBPeerClient.h"
#import "RTCFileRecorder.h"
#import "RTCVideoRenderer.h"
#import "RTCPeerConnectionFactory.h"
#import "RTCMediaConstraints.h"
#import "RTCPair.h"
#import "RBVideoPeer.h"
#import "RTCVideoSource.h"
#import "RTCSessionDescription.h"
#import "RTCPeerConnection.h"
#import "RTCPeerConnectionInterface.h"
#import "RBVideoInfoSession.h"
#import "RTCSessionDescriptionDelegate.h"
#import "RTCAudioTrack.h"
#import "RTCMediaSource.h"
#import "RTCMediaStream.h"
#import "RTCAudioSource.h"
#import "RTCVideoTrack.h"
#import "RBSdpBuilder.h"
#import "RTCLogging.h"
#import "RTCAVFoundationVideoSource.h"
/*
 *  webrtc constants
 */
#define FIELD_TRIAL_VP9  @"WebRTC-SupportVP9/Enabled/"
#define VIDEO_TRACK_ID  @"ARDAMSv0"
#define AUDIO_TRACK_ID  @"ARDAMSa0"

#define DTLS_SRTP_KEY_AGREEMENT_CONSTRAINT  @"DtlsSrtpKeyAgreement"

/*
 *   audio constraints
 */
#define AUDIO_ECHO_CANCELLATION_CONSTRAINT  @"googEchoCancellation"
#define AUDIO_AUTO_GAIN_CONTROL_CONSTRAINT  @"googAutoGainControl"
#define AUDIO_HIGH_PASS_FILTER_CONSTRAINT  @"googHighpassFilter"
#define AUDIO_NOISE_SUPPRESSION_CONSTRAINT  @"googNoiseSuppression"

/*
 *   video constraints
 */
#define MAX_VIDEO_WIDTH_CONSTRAINT  @"maxWidth"
#define MIN_VIDEO_WIDTH_CONSTRAINT  @"minWidth"
#define MAX_VIDEO_HEIGHT_CONSTRAINT  @"maxHeight"
#define MIN_VIDEO_HEIGHT_CONSTRAINT  @"minHeight"
#define MAX_VIDEO_FPS_CONSTRAINT  @"maxFrameRate"
#define MIN_VIDEO_FPS_CONSTRAINT  @"minFrameRate"

@interface RBPeerClient ()<RTCPeerConnectionDelegate,RTCSessionDescriptionDelegate>{
    BOOL shouldDellocPeerConnect;
}

@property(nonatomic,strong) RTCMediaConstraints * mConnConstraints;
@property(nonatomic,strong) RTCMediaConstraints * mAudioConstraints;
@property(nonatomic,strong) RTCFileRecorder * mFileRecord;
@property(nonatomic,strong) RTCPeerConnectionFactory * factory;
@property(nonatomic,strong) RBVideoAddress      * mAddress;
@property(nonatomic,strong) RTCSessionDescription * mLocalSdp;
@property(nonatomic,strong) RTCPeerConnection * mPeerConnection;
@property(nonatomic,strong) RBVideoInfoSession * mSession;
@property(nonatomic,strong) RTCAudioTrack      * mAudioTrack;
@end

@implementation RBPeerClient
@synthesize mSession = _mSession;

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (RBPeerClient *)create:(RBConsole *)console Configuration:(RBConfiguration *)config{
    RBPeerClient * client = [[RBPeerClient alloc] init];
    client.console = console;
    client.mController = [RBPeerController create:client];
    [client.mController onIdle];
    
    [client inits];
    return client;
}


- (void)startRecordingVideoWithFilePath:(NSString *)path{
    [self.mFileRecord StartRecording:path]
    ;}

- (void)stopRecoredingVideo{
    [self.mFileRecord StopRecording];
}

- (void)inits
{
    [RTCPeerConnectionFactory initializeSSL];
    _factory = [[RTCPeerConnectionFactory alloc] init];
    _surfaceRender = [[RBSurfaceRender alloc] init];
    shouldDellocPeerConnect = YES;

}


- (void)bind:(RBVideoAddress *)address :(RBVideoCredential *)credential{
    self.mAddress = address;
    [self.mController bind:address];
}

- (void)connect:(RBVideoPeer * )callee{

}

- (void)call:(RBVideoPeer *) callee{
    [self.mController call:callee];
    self.mFileRecord = [[RTCFileRecorder alloc] initWithFileRecorder:_recordDelegate];

}

- (void)sendBye{
    [self.console sendBye:_mSession];
}

- (void)reset{
    [self.mFileRecord StopRecording];
    [self resetConnection];
}


- (void)free{
    [self releaseConnection];

    [self.mFileRecord free];
    [self.mController free];
    self.mController = nil;
    self.console = nil;
    _mFileRecord = nil;
    _stateDelegate = nil;
    _stateDelegate = nil;
    _surfaceRender = nil;
    [RTCPeerConnectionFactory deinitializeSSL];

}

- (void)sendCandidates:(NSArray *)candidates{
    if(candidates != nil){
        for(RTCICECandidate * ca in candidates){
            [_console sendIceCandidate:_mSession IceCandidate:ca];
        }
    }
}
/* 创建本地视频轨道 */
- (RTCVideoTrack *)createLocalVideoTrack {
    
    RTCVideoTrack* localVideoTrack = nil;
    /* 设置媒体流默认选项 */
    RTCMediaConstraints *mediaConstraints =
    [self defaultMediaStreamConstraints];
    
    /* 设置视频源 */
    RTCAVFoundationVideoSource *source =
    [[RTCAVFoundationVideoSource alloc] initWithFactory:_factory
                                            constraints:mediaConstraints];
    
    /* 创建本地视频轨 */
    localVideoTrack =
    [[RTCVideoTrack alloc] initWithFactory:_factory
                                    source:source
                                   trackId:@"ARDAMSv0"];
    return localVideoTrack;
}
- (RTCMediaStream *)createLocalMediaStream {
    RTCLog(@"createLocalMediaStream");
    
    RTCMediaStream* localStream = [_factory mediaStreamWithLabel:@"ARDAMS"];

    RTCAudioTrack * track = [_factory audioTrackWithID:@"ARDAMSa0"];
    [_surfaceRender setLocalAudioTrack:track];

    [localStream addAudioTrack:track];
    
    track.enabled = YES;
    return localStream;
}

- (void)handleCall:(RBVideoPeer *)mdest{
    self.mSession = [RBVideoInfoSession videoSession:mdest.userId];
    [self.console startCall:self.mSession];
}


- (void)addCandidatess:(NSArray *)candidates{
    RTCLog(@"addCandidatess");
    if (candidates != nil && _mPeerConnection != nil) {
        for (RTCICECandidate * candidate in candidates) {
            [_mPeerConnection addICECandidate:candidate];
        }
    }
}

- (void)releaseConnection{
    RTCLog(@"releaseConnection");
    _mLocalSdp = nil;
    if(_mPeerConnection != nil && shouldDellocPeerConnect){
        shouldDellocPeerConnect = NO;
        [_mPeerConnection close];
        _mPeerConnection = nil;
    }
    _surfaceRender.remoteVideoTrack = nil;
    _surfaceRender.localAudioTrack = nil;
}

- (void)setRemoteDescription:(RTCSessionDescription *) sdp{
    if(_mPeerConnection == nil || sdp == nil){
        return;
    }
    RTCLog(@"setRemoteDescription sdp start");
    RTCSessionDescription * sdpRemote = [RBSdpBuilder descriptionForDescription:sdp preferredVideoCodec:@"H264"];
    [_mPeerConnection setRemoteDescriptionWithDelegate:self sessionDescription:sdpRemote];
    RTCLog(@"setRemoteDescription sdp end");

}

- (BOOL)checkSession:(RBVideoInfoSession *)sessioin{
    if(sessioin == nil)
        return NO;
    if(_mSession == nil)
        return NO;
    return [sessioin.mSessionID isEqualToString:_mSession.mSessionID];
    
}


- (void)onVideoControlEvent:(int)event VideoSession:(RBVideoInfoSession *)session Code:(int)code Obj:(id)obj{
    if(event == EVENT_ACCEPTCALL){
        if(![self checkSession:session])
            return;
        RTCLog(@"on EVENT_ACCEPTCALL");
        if(self.mPeerConnection == nil)
            return;
        [self.mPeerConnection createOfferWithDelegate:self constraints:[self defaultAnswerConstraints]];
        
    }else if(event == EVENT_ENDCALL){
        RTCLog(@"on EVENT_ENDCALL");
        if(![self checkSession:session])
            return;
        if(self.stateDelegate){
            [self.stateDelegate onCallHungup:session];
        }
        [self resetConnection];
    }else if(event == EVENT_ICE){
        RTCLog(@"on EVENT_ICE");
        if(![self checkSession:session])
            return;
        [self.mController addCandidate:obj];
    }else if(event == EVENT_MUTE){
        RTCLog(@"on EVENT_MUTE");

        BOOL audio = (Boolean) code;
        if (_mAudioTrack != nil) {
            [_mAudioTrack setEnabled:audio];
        }
    }else if(event == EVENT_SDP){
        if(![self checkSession:session])
            return;
        RTCLog(@"onAnswerReceived");
        [self setRemoteDescription:obj];
    }


}

- (void)resetConnection{
    RTCLog(@"resetConnection");
    [self releaseConnection];
    [self.mController onIdle];

}


- (void)preparePeerConnection:(NSArray * )array{
    RTCConfiguration *config = [[RTCConfiguration alloc] init];
    config.iceServers = array;
    RTCMediaConstraints *constraints = [self defaultPeerConnectionConstraints];
    _mPeerConnection = [_factory peerConnectionWithConfiguration:config constraints:constraints delegate:self];
    
    RTCMediaStream *localStream = [self createLocalMediaStream];
    [_mPeerConnection addStream:localStream];

}



#pragma mark -

- (RTCMediaConstraints *)defaultMediaStreamConstraints {
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:nil
     optionalConstraints:nil];
    return constraints;
}

- (RTCMediaConstraints *)defaultAnswerConstraints {
    return [self defaultOfferConstraints];
}

- (RTCMediaConstraints *)defaultOfferConstraints {
    NSArray *mandatoryConstraints = @[
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                      ];
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:mandatoryConstraints
     optionalConstraints:nil];
    return constraints;
}

- (RTCMediaConstraints *)defaultPeerConnectionConstraints {
   
    
    NSString *value = _isLoopback ? @"false" : @"true";
    NSArray *optionalConstraints = @[
                                     [[RTCPair alloc] initWithKey:@"DtlsSrtpKeyAgreement" value:value]
                                     ];
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:nil
     optionalConstraints:optionalConstraints];
    return constraints;
}



#pragma mark -   RTCPeerConnectionDelegate

// Triggered when the SignalingState changed.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
 signalingStateChanged:(RTCSignalingState)stateChanged{
    RTCLog(@"onSignalingChange");
}

// Triggered when media is received on a new stream from remote peer.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
           addedStream:(RTCMediaStream *)stream{
    RTCLog(@"Received %lu video tracks and %lu audio tracks",
           (unsigned long)stream.videoTracks.count,
           (unsigned long)stream.audioTracks.count);
    
    
    if (stream.videoTracks.count) {
        RTCVideoTrack *videoTrack = stream.videoTracks[0];
        [videoTrack SetRecorder:self.mFileRecord];
        [_surfaceRender setRemoteVideoTrack:videoTrack];
    }
    if(stream.audioTracks.count){
        
        RTCAudioTrack *audioTrack = stream.audioTracks[0];
        [audioTrack SetRecorder:self.mFileRecord];
    }
}

// Triggered when a remote peer close a stream.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
         removedStream:(RTCMediaStream *)stream{
    RTCLog(@"Stream was removed.");
}

// Triggered when renegotiation is needed, for example the ICE has restarted.
- (void)peerConnectionOnRenegotiationNeeded:(RTCPeerConnection *)peerConnection{
    RTCLog(@"WARNING: Renegotiation needed but unimplemented.");
}

// Called any time the ICEConnectionState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
  iceConnectionChanged:(RTCICEConnectionState)newState{
    RTCLog(@"ICE state changed: %@", [self iceConnectionStateToText:newState]);
    if(newState == RTCICEConnectionConnected){
        RTCLog(@"onIceConnected");
        [_mController onConnected];
        if(self.stateDelegate){
            [self.stateDelegate onCallConnected:_mSession];
        }
    }else if (newState == RTCICEConnectionDisconnected || newState == RTCICEConnectionFailed || newState == RTCICEConnectionClosed){
        if(shouldDellocPeerConnect)
            return;
        if(self.stateDelegate){
            [self.stateDelegate onVideoError:_mSession ErrorCode:EVENT_VIDEO_ERROR_CONNECT_FAILED ErrorMsg:@"ice disconnection."];
        }
        
        [_mController onError:EVENT_VIDEO_ERROR_CONNECT_FAILED Msg:@"ice disconnection."];
    }
}

// Called any time the ICEGatheringState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
   iceGatheringChanged:(RTCICEGatheringState)newState{
    RTCLog(@"iceGatheringChanged %d",newState);
}

// New Ice candidate have been found.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
       gotICECandidate:(RTCICECandidate *)candidate{
    RTCLog(@"onIceCandidate");
    [_mController sendCandidate:candidate];
}

// New data channel has been opened.
- (void)peerConnection:(RTCPeerConnection*)peerConnection
    didOpenDataChannel:(RTCDataChannel*)dataChannel{
    
}
- (NSString *)iceConnectionStateToText:(RTCICEConnectionState)state {
    switch (state) {
        case RTCICEConnectionNew:
            return @"RTCICEConnectionNew";
        case RTCICEConnectionChecking:
            return @"RTCICEConnectionChecking";
        case RTCICEConnectionConnected:
            return @"RTCICEConnectionConnected";
        case RTCICEConnectionCompleted:
            return @"RTCICEConnectionCompleted";
        case RTCICEConnectionFailed:
            return @"RTCICEConnectionFailed";
        case RTCICEConnectionDisconnected:
            return @"RTCICEConnectionDisconnected";
        case RTCICEConnectionClosed:
            return @"RTCICEConnectionClosed";
        default:
            return [NSString stringWithFormat:@"Unkown state: %d", state];
    }
}

#pragma mark -  RTCSessionDescriptionDelegate<NSObject>

// Called when creating a session.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didCreateSessionDescription:(RTCSessionDescription *)sdp
                 error:(NSError *)error{
    if(error){
        [_mController onError:EVENT_VIDEO_ERROR_UNKOWN Msg:[NSString stringWithFormat:@"createSDP error:  %@",error]];
        return;
    }
    
    if(_mPeerConnection == nil){
        return;
    }
    RTCLog(@"onCreateSuccess");
    if (_mLocalSdp != nil) {
        return;
    }
    RTCSessionDescription * sdpRemote = [RBSdpBuilder descriptionForDescription:sdp preferredVideoCodec:@"H264"];

    [_mPeerConnection setLocalDescriptionWithDelegate:self sessionDescription:sdpRemote];
    _mLocalSdp = sdpRemote;
}

// Called when setting a local or remote description.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didSetSessionDescriptionWithError:(NSError *)error{
    if(error){
        [_mController onError:EVENT_VIDEO_ERROR_UNKOWN Msg:[NSString stringWithFormat:@"setSDP error:  %@",error]];
        return;
    }
    RTCLog(@"onSetSuccess");
    if(_mPeerConnection == nil)
        return;
    if(_mLocalSdp != nil && _mPeerConnection.remoteDescription == nil){
        [_console sendOfferSdp:_mSession SDP:_mLocalSdp.description];
        RTCLog(@"send offer");
    }
    if(_mPeerConnection.remoteDescription != nil && _mPeerConnection.localDescription != nil){
        
        [_mController onConnecting];
        RTCLog(@"enter connecting state");
    }

}


- (void)dealloc{
    RTCLog(@"dealloc %@",self);
}
@end
