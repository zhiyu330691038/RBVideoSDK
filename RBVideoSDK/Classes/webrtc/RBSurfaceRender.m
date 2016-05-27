//
//  RBSurfaceRender.m
//  TestVideo
//
//  Created by Zhi Kuiyu on 16/5/24.
//  Copyright © 2016年 Zhi Kuiyu. All rights reserved.
//

#import "RBSurfaceRender.h"
#import "RTCEAGLVideoView.h"
#import "RTCEAGLVideoView.h"
#import "RTCVideoTrack.h"
#import "RTCAudioTrack.h"

@implementation RBSurfaceRender

- (instancetype)init
{
    self = [super init];
    if (self) {
        _remoteVideoView = [[RBEAVideoView alloc] initWithFrame:CGRectZero];
        _remoteVideoView.delegate = self;
    }
    return self;
}

-(void)setRemoteVideoTrack:(RTCVideoTrack *)remoteVideoTrack{
    if(_remoteVideoTrack == remoteVideoTrack)
        return;
    [_remoteVideoTrack removeRenderer:_remoteVideoView];
    _remoteVideoTrack = nil;
    [_remoteVideoView renderFrame:nil];
    _remoteVideoTrack = remoteVideoTrack;
    [_remoteVideoTrack addRenderer:_remoteVideoView];
}


#pragma mark - RTCEAGLVideoViewDelegate

- (void)videoView:(RTCEAGLVideoView*)videoView didChangeVideoSize:(CGSize)size{
    _remoteVideoView.videoSize = size;
    if(_remoteVideoView.VideoSizeChange){
        _remoteVideoView.VideoSizeChange(size);
    }

}

@end


@implementation RBEAVideoView

@end