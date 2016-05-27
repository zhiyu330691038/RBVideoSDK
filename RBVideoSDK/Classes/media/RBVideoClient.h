//
//  RBVideoClient.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoClient_h
#define RBVideoClient_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RBVideoAddress.h"
#import "RBVideoCredential.h"
#import "RBVideoPeer.h"
#import "RBVideoCallDelegate.h"
#import "RBVideoEvent.h"
#import "RBVideoConfiguration.h"

@interface RBVideoClient : NSObject

/**
 *  @author 智奎宇, 16-05-18 11:05:12
 *
 *  视频连接状态的回调
 */
@property (nonatomic,weak) id<RBVideoEventDelegate> delegate;

/**
 *  @author 智奎宇, 16-05-18 11:05:55
 *
 *  连接视频的地址
 */
@property (nonatomic,strong) RBVideoAddress  *  connectAddress;

/**
 *  @author 智奎宇, 16-05-18 11:05:27
 *
 *  展示远程画面的View
 */
@property (nonatomic,readonly,strong) UIView * remoteRendererView;

/**
 *  @author 智奎宇, 16-05-18 12:05:57
 *
 *  视频的认证信息
 */
@property(nonatomic,strong) RBVideoCredential * videoCredential;


/**
 *  @author 智奎宇, 16-05-18 15:05:56
 *
 *  视频配置
 */
@property(nonatomic,strong) RBVideoConfiguration * configation;
/**
 *  @author 智奎宇, 16-05-25 11:05:28
 *
 *  获取视频View
 *
 */
- (UIView *)getVideoView;

/**
 *  @author 智奎宇, 16-05-18 12:05:10
 *
 *  开始连接视频（必须设置 connectAddress 视频连接地址，videoCredential 视频的认证信息）
 */
- (void)begin;

/**
 *  @author 智奎宇, 16-05-20 14:05:09
 *
 *  呼叫视频设备
 *
 *  @param clientId 设备id
 */
- (void)call:(NSString *)clientId;

/**
 *  @author 智奎宇, 16-05-18 12:05:34
 *
 *  展示画面
 */
- (void)start;
/**
 *  @author 智奎宇, 16-05-18 12:05:28
 *
 *  暂停展示画面
 */
- (void)pause;

/**
 *  @author 智奎宇, 16-05-18 12:05:22
 *
 *  断开视频连接，如果想重新连接必须 调用begin
 */
- (void)stop;

/**
 *  @author 智奎宇, 16-05-18 12:05:26
 *
 *  视频视频里面的资源
 */
- (void)free;


/**
 *  @author 智奎宇, 16-05-26 20:05:13
 *
 *  视频截图
 *
 */
- (void)screenCapture;

/**
 *  @author 智奎宇, 16-05-26 20:05:03
 *
 *  开始录制视频
 */
- (void)startRecoredVideo;


/**
 *  @author 智奎宇, 16-05-26 20:05:03
 *
 *  停止录制视频
 */
- (void)stopRecoredVideo;
@end

#endif /* RBVideoClient_h */
