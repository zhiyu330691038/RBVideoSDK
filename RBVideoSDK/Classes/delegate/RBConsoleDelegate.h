//
//  RBConsoleDelegate.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/17.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBVideoInfoSession.h"

typedef enum {
    EVENT_CONNECT_OPENED,
    EVENT_CONNECT_FAIL,
    EVENT_CONNECT_LOGIN,
    EVENT_CONNECT_LOGOUT,
    EVENT_CONNECT_LOGINFAIL,
    EVENT_CONNECT_RESTART,
} RBConsoleState;


@protocol RBConsoleDelegate <NSObject>


- (void)videoConnectState:(RBConsoleState) event ErrorCode:(int)errorCode Reason:(NSObject *)reason;

- (void)videoConnectControlEvent:(int) event ErrorCode:(int)errorCode  VideoSession:(RBVideoInfoSession *)secssion Code:(int)code Para:(NSObject *) obj;


@end
