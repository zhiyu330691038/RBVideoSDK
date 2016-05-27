//
//  RBVideoCallDelegate.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoCallDelegate_h
#define RBVideoCallDelegate_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CallState) {
    ACCEPT,
    REJECT,
    HALL_STATE_OPEN,
    BUSY,
    ERROR,
};

@protocol RBVideoCallDelegate
- (void)onError:(int)errCode errMsg:(NSString*)errMsg;
- (CallState)onIncomingCall:(NSString*)from;
- (void)onCallAccepted;
- (void)onCallConnected;
- (void)onCallRejected:(NSString*)reason;
- (void)onCallOffline;
- (void)onHangup;
@end

#endif /* RBVideoCallDelegate_h */
