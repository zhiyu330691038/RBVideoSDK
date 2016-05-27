//
//  RBVideoClient.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoCallDelegate.h"
#import "RBVideoClient.h"
#import "RBConsole.h"
#import "RBVideoConfiguration.h"
#import "RBVideoInfoSession.h"
#import "RBPeerClient.h"
#import "RBVideoStateDelegate.h"
#import "RBICometEventDelegate.h"
#import "RTCLogging.h"
#import "RBPeerState.h"

@interface RBVideoClient ()<RBConsoleDelegate,RBVideoStateDelegate,RTCRecorderListenerDelegate,RBImageCaptureDelegate>{
    NSString * callClientID;//呼叫视频id
    
    RBConsole * console;
    RBVideoInfoSession * currentSession;
    RBPeerClient * peerClient;
}
@end

@implementation RBVideoClient

- (void)openConnection{
    if(![self checkConnectInfo])
        return;
    
    _configation = [[RBVideoConfiguration alloc] init];

    console = [[RBConsole alloc] init];
    [console setCDelegate:self];
    [console bind:_connectAddress VideoCredential:_videoCredential];
    
    [self initPeerClient];

}


- (BOOL)checkConnectInfo{
    
    if(_delegate == nil){
        RTCLog(@"没有设置视频回调delegate");
    }
    if(_connectAddress == nil ||  _connectAddress.url == nil){
        if(_delegate && [_delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [_delegate videoConnectOnEvent:VIDEO_INFO_SERVER_ADDRESS_INVALID Code:0 Msg:@"视频连接地址错误 或没有设置视频服务器地址"];
        }
        return NO;
    }else if(_videoCredential == nil || _videoCredential.userId == nil || _videoCredential.token == nil || _videoCredential.password == nil){
    
        if(_delegate && [_delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [_delegate videoConnectOnEvent:VIDEO_INFO_LOGIN_INFO_INVALID Code:0 Msg:@"没有设置用户信息,请检测 用户token ，userid，password"];
        }
        return NO;
    }
    
    return YES;
}

- (void)initPeerClient{
    peerClient = [RBPeerClient create:console Configuration:[RBConfiguration new]];
    peerClient.stateDelegate = self;
    peerClient.recordDelegate = self;
    peerClient.captureDelegate = self;
    [peerClient bind:_connectAddress :_videoCredential];
}


/**
 *  @author 智奎宇, 16-05-25 11:05:28
 *
 *  获取视频View
 *
 */
- (UIView *)getVideoView{
    if(peerClient == nil){
        RTCLog(@"should begin sdk");
        return nil;
    }
    return [[peerClient surfaceRender] remoteVideoView];

}

/**
 *  @author 智奎宇, 16-05-18 12:05:10
 *
 *  开始连接视频（必须设置 connectAddress 视频连接地址，videoCredential 视频的认证信息）
 */
- (void)begin{
    [self openConnection];
    RTCLog(@"-----");
}


/**
 *  @author 智奎宇, 16-05-20 14:05:09
 *
 *  呼叫视频设备
 *
 *  @param clientId 设备id
 */
- (void)call:(NSString *)clientId{
    
    RBPeerState * ss = peerClient.mController.mState;
    if([ss isKindOfClass:[RBHandshake class]] || [ss isKindOfClass:[RBStandby class]]){
    
        callClientID = nil;
        
        if(!console.mLoginSucess){
            if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
                [self.delegate videoConnectOnEvent:VIDEO_INFO_LOGIN_FAIL Code:0 Msg:@"is no login"];
            }
            return;
        }
        
        [peerClient call:[RBVideoPeer videoPeerWithUserID:clientId]];
    
    }else{
        NSString * msg = nil;
        if([ss isKindOfClass:[RBIdle class]]){
            msg = @"视频是闲置状态";
        }else if([ss isKindOfClass:[RBPrepare class]]){
            msg = @"视频是请求turn状态";
        }else if([ss isKindOfClass:[RBConnecting class]]){
            msg = @"视频是正在连接";
        }else if([ss isKindOfClass:[RBConnected class]]){
            msg = @"视频已经连接";
        }
        
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CALL_NO_READLY Code:0 Msg:msg];
        }
    }
   
}

/**
 *  @author 智奎宇, 16-05-18 12:05:34
 *
 *  展示画面
 */
- (void)start{
    
    
}

/**
 *  @author 智奎宇, 16-05-26 20:05:13
 *
 *  视频截图
 *
 */
- (void)screenCapture{
    RBPeerState * ss = peerClient.mController.mState;
    if([ss isKindOfClass:[RBConnected class]]){
        UIImage * img = [(RBEAVideoView *)[self getVideoView] getLastDrawnFrameImage];
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CAPTURE_RESULT Code:0 Msg:img];
        }
    }else{
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CAPTURE_RESULT_ERROR Code:0 Msg:@"只能在观看视频时截屏"];
        }
    }

}
/**
 *  @author 智奎宇, 16-05-26 20:05:03
 *
 *  停止录制视频
 */
- (void)stopRecoredVideo{
    [peerClient stopRecoredingVideo];


}


/**
 *  @author 智奎宇, 16-05-26 20:05:03
 *
 *  开始录制视频
 */
- (void)startRecoredVideo{
    RBPeerState * ss = peerClient.mController.mState;
    if([ss isKindOfClass:[RBConnected class]]){
        NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path=[Paths objectAtIndex:0];
        [peerClient startRecordingVideoWithFilePath:[path stringByAppendingString:@"/recored.mp4"]];
    }else{
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_RECORDER_ERROR Code:0 Msg:@"只能在观看视频时录制"];
        }
    }

}
/**
 *  @author 智奎宇, 16-05-18 12:05:28
 *
 *  暂停展示画面
 */
- (void)pause{
    
    
}

/**
 *  @author 智奎宇, 16-05-18 12:05:22
 *
 *  断开视频连接，如果想重新连接必须 调用begin
 */
- (void)stop{
    [peerClient sendBye];
    [peerClient resetConnection];
    [peerClient bind:_connectAddress :_videoCredential];
}

/**
 *  @author 智奎宇, 16-05-18 12:05:26
 *
 *  视频视频里面的资源
 */
- (void)free{
    [peerClient free];
    [self stop];
    _configation = nil;
    _connectAddress = nil;
    _videoCredential = nil;
    peerClient = nil;
    [console free];
    console = nil;
}

#pragma mark - RBConsoleDelegate


- (void)videoConnectState:(RBConsoleState) event ErrorCode:(int)errorCode Reason:(id)reason{

    if(event == EVENT_CONNECT_OPENED){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_SERVER_CONNECT Code:0 Msg:reason];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectProgress:)]){
            [self.delegate videoConnectProgress:10];
        }
    }else if(event == EVENT_CONNECT_LOGIN){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_SERVER_LOGIN_SCURSS Code:30 Msg:reason];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectProgress:)]){
            [self.delegate videoConnectProgress:30];
        }
        if(callClientID != nil){
            [self call:callClientID];
            
        }
        
    }else if (event == EVENT_CONNECT_LOGINFAIL) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_SERVER_LOGIN_FAIL Code:errorCode Msg:reason];
        }
        [self stop];
    }else if(event == EVENT_CONNECT_FAIL){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_SERVER_CLOSE Code:errorCode Msg:reason];
        }
        [self stop];
    }else if(event == EVENT_CONNECT_RESTART){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_SERVER_RECONNECT Code:errorCode Msg:reason];
        }
    }
    
}

- (void)videoConnectControlEvent:(int) event ErrorCode:(int)errorCode  VideoSession:(RBVideoInfoSession *)secssion Code:(int)code Para:(NSObject *) obj{
    [peerClient onVideoControlEvent:event VideoSession:secssion Code:code Obj:obj];

    if(event == EVENT_ENDCALL){
        [self stop];

    }else if(event == EVENT_ACCEPTCALL){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CALL_ACCEPT Code:0 Msg:obj];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectProgress:)]){
            [self.delegate videoConnectProgress:40];
        }
    }else if(event == EVENT_SDP){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CALL_ANSWER Code:0 Msg:obj];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectProgress:)]){
            [self.delegate videoConnectProgress:50];
        }
    }else if(event == EVENT_ICE){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CALL_INFO Code:0 Msg:obj];
        }
    }else if(event == EVENT_REJECTCALL){
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
            [self.delegate videoConnectOnEvent:VIDEO_CALL_FAIL Code:0 Msg:obj];
        }
        [self stop];
    }
}



#pragma mark - RBVideoStateDelegate

- (void)onVideoError:(RBVideoInfoSession *)setcion ErrorCode:(int)errorCode ErrorMsg:(NSString *)errMsg{
    if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
        [self.delegate videoConnectOnEvent:VIDEO_CONNECT_FAIL Code:0 Msg:@""];
    }
}

- (void)onCallConnected:(RBVideoInfoSession *)setcion{
    if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
        [self.delegate videoConnectOnEvent:VIDEO_CONNECT_SCUESS Code:0 Msg:@""];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
        [self.delegate videoConnectProgress:90];
    }
}


- (void)onCallHungup:(RBVideoInfoSession *)setcion{
    if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
        [self.delegate videoConnectOnEvent:VIDEO_CONNECT_FAIL Code:0 Msg:@""];
    }

}

#pragma mark - RTCRecorderListenerDelegate
//RECORDER_INITED = 0,
//RECORDER_INIT_ERROR,
//RECORDER_STARTED,
//RECORDER_STOPED,
//STREAN_OUTPUT_ERROR,
- (void)notify:(int )Msg Ext:(int)Ext{
    VideoConnectState state ;
    NSString * msg;
    if (Msg == 3) {
        state = VIDEO_RECORDER_STOPPED;
        NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path=[Paths objectAtIndex:0];
        
        msg = [path stringByAppendingString:@"/recored.mp4"];
    }else if (Msg == 2){
        state = VIDEO_RECORDER_STARTED;
      
    }else{
        state = VIDEO_RECORDER_UNKOWN;

       
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(videoConnectOnEvent:Code:Msg:)]){
        [self.delegate videoConnectOnEvent:state Code:0 Msg:msg];
    }
}


#pragma mark - RBImageCaptureDelegate

- (void)onCaptureResult:(UIImage *) capImage Reason:(NSString *)reason{

}


- (void)dealloc{
    RTCLog(@"%@ dealloc",self);
    
}
@end