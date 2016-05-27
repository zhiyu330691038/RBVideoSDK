//
//  RBPeerClient.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBConsole.h"
#import "RBVideoCredential.h"
#import "RBVideoAddress.h"
#import "RBPeerController.h"
#import "RBConfiguration.h"
#import "RBVideoStateDelegate.h"
#import "RTCFileRecorder.h"
#import "RBImageCaptureDelegate.h"
#import "RBVideoInfoSession.h"
#import "RBSurfaceRender.h"
@interface RBPeerClient : NSObject{
    NSMutableArray * mLocalCandidates;
}

@property(nonatomic,weak) id<RBVideoStateDelegate> stateDelegate;
@property(nonatomic,weak) id<RTCRecorderListenerDelegate> recordDelegate;
@property(nonatomic,weak) id<RBImageCaptureDelegate> captureDelegate;
@property(nonatomic,assign) BOOL    isLoopback;
@property(nonatomic,strong) RBConsole * console;
@property(nonatomic,strong) RBPeerController *mController;
@property(nonatomic,strong) RBConfiguration *config;
@property(nonatomic,strong) RBSurfaceRender * surfaceRender;

+ (RBPeerClient *)create:(RBConsole *)console Configuration:(RBConfiguration *)config;

- (void)startRecordingVideoWithFilePath:(NSString *)path;
- (void)stopRecoredingVideo;

- (void)bind:(RBVideoAddress *)address :(RBVideoCredential *)credential;
- (void)free;
- (void)sendCandidates:(NSArray *)candidates;

- (void)handleCall:(RBVideoPeer *)mdest;

- (void)addCandidatess:(NSArray *)candidates;

- (void)resetConnection;

- (void)call:(RBVideoPeer *) callee;

- (void)sendBye;

- (void)preparePeerConnection:(NSArray * )array;

- (void)onVideoControlEvent:(int)event VideoSession:(RBVideoInfoSession *)session Code:(int)code Obj:(id)obj;

@end
