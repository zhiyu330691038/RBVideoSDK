//
//  RBVideoEvent.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/17.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoEvent_h
#define RBVideoEvent_h

typedef enum  {
    //用户登录信息
    EVENT_LOGIN_INFO_SCUESS,
    EVENT_LOGIN_INFO_TOKEN_INVALID,
    EVENT_LOGIN_VIDEO_ADDRESS_INVALID,
    EVENT_LOGIN_INFO_INVALID,
    EVENT_LOGIN_OFFLINE,
    EVENT_LOGIN_UNKOWN,
    
    //视频连接
    EVENT_VIDEO_ACCEPT,
    EVENT_VIDEO_REJECTCALL,
    EVENT_VIDEO_HALL_STATE_OPEN,
    EVENT_VIDEO_BUSY,
    EVENT_VIDEO_ERROR,
    EVENT_VIDEO_CONNECTED,
    EVENT_VIDEO_PROGRESS,
    EVENT_VIDEO_CLOSE,
    EVENT_VIDEO_ERROR_PERMISSION ,
    EVENT_VIDEO_ERROR_OFFLINE ,
    EVENT_VIDEO_ERROR_OTHER ,
    EVENT_VIDEO_ERROR_UNKOWN  ,
    EVENT_ERROR_UNKOWN  ,
    EVENT_VIDEO_ERROR_CONNECT_FAILED,
    
    //视频截图
    EVENT_CAPTURE_RESULT,
    EVENT_CAPTURE_RESULT_ERROR,
    
    //视频录制视频
    EVENT_RECORDER_STARTED,
    EVENT_RECORDER_STOPPED,
    EVENT_RECORDER_ERROR_INIT   ,
    EVENT_RECORDER_ERROR_OUTPUT ,
    EVENT_RECORDER_UNKOWN
    
    
} VideoEvent;

typedef enum {
    VIDEO_INFO_SERVER_ADDRESS_INVALID,//视频连接服务器错误
    VIDEO_INFO_LOGIN_INFO_INVALID,//用户登录信息错误
    VIDEO_INFO_LOGIN_FAIL,//用户登录信息错误
    
    VIDEO_SERVER_CONNECT,//视频服务器连接成功
    VIDEO_SERVER_CLOSE,//视频服务器断开
    VIDEO_SERVER_RECONNECT,//视频服务器重新连接

    VIDEO_SERVER_LOGIN_SCURSS,//视频服务登陆成功
    VIDEO_SERVER_LOGIN_FAIL,//视频服务登陆失败
    
    VIDEO_CALL_NO_READLY,//视频呼叫状态错误
    VIDEO_CALL_ACCEPT,//呼叫视频成功
    VIDEO_CALL_FAIL,//呼叫视频成功
    VIDEO_CALL_ANSWER,//收到视频连接回复
    VIDEO_CALL_INFO,//收到视频连接信息 VIDEO_CALL_ANSWER 顺序不确定
    
    VIDEO_CONNECT_SCUESS,//视频连接成功
    VIDEO_CONNECT_FAIL,//视频连接失败
    //视频截图
    VIDEO_CAPTURE_RESULT,
    VIDEO_CAPTURE_RESULT_ERROR,
    
    VIDEO_RECORDER_STARTED,
    VIDEO_RECORDER_STOPPED,
    VIDEO_RECORDER_UNKOWN,
    VIDEO_RECORDER_ERROR,
    
} VideoConnectState;

typedef enum {
    VIDEO_ERROR_OFFLINE,
    VIDEO_ERROR_PERMISSION,
    VIDEO_ERROR_SERVER,
} VideoCallEvent;

@protocol RBVideoEventDelegate <NSObject>

- (void)videoConnectOnEvent:(VideoConnectState) event Code:(int)code Msg:(id)msg;

- (void)videoConnectProgress:(int)progress;

@end



#endif /* RBVideoEvent_h */
