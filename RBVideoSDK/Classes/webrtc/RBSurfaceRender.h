//
//  RBSurfaceRender.h
//  TestVideo
//
//  Created by Zhi Kuiyu on 16/5/24.
//  Copyright © 2016年 Zhi Kuiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTCVideoTrack;
@class RTCAudioTrack;

#import "RTCEAGLVideoView.h"

@interface RBEAVideoView : RTCEAGLVideoView
@property(nonatomic,assign) CGSize videoSize;
@property (nonatomic,copy) void(^VideoSizeChange)(CGSize);

@end


@interface RBSurfaceRender : NSObject<RTCEAGLVideoViewDelegate>

@property(nonatomic, readonly)  RBEAVideoView       *   remoteVideoView;
@property(nonatomic, strong)    RTCVideoTrack       *   remoteVideoTrack;
@property(nonatomic, strong)    RTCAudioTrack       *   localAudioTrack;

@end
