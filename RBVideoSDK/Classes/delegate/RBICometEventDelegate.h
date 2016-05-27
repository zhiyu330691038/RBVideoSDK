//
//  RBICometEventDelegate.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBVideoEvent.h"
@class RBVideoInfoSession;


static int EVENT_ENDCALL = 1;
static int EVENT_ACCEPTCALL = 3;
static int EVENT_REJECTCALL = 4;
static int EVENT_MUTE = 7;
static int EVENT_SDP = 8;
static int EVENT_ICE = 9;


@protocol RBICometEventDelegate <NSObject>

- (void)onLoginResult:(BOOL)isSucess Event:(VideoEvent)code Reason:(NSString *)reason;

- (void)onHeatBeatAck:(BOOL) online;

- (void)onVideoControlEvent:(int)event VideoSecssion:(RBVideoInfoSession *)secssion ErrorCode:(VideoEvent)errorcode Reason:(NSObject *)reason;

@end
