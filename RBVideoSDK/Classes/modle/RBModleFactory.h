//
//  RBModleFactory.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBIModleDeal.h"
#import "RBICometEventDelegate.h"
#import "RBVideoCallDelegate.h"
@class RBMsgBaseModle;

@class RBVideoInfoSession;
@class RBVideoCredential;
@class RBLoginModle;
@class RTCICECandidate;

@interface RBModleFactory : NSObject<RBIModleDeal>

@property(nonatomic,weak) id<RBICometEventDelegate> delegate;

@property(nonatomic,strong) RBLoginModle * loginModle;

- (void)setLoginParam:(RBVideoCredential *)param;

- (NSString *)getCallModle:(RBVideoInfoSession *)section;

- (NSString *)getCallResponse:(RBVideoInfoSession *)section CallState:(CallState) callstate;

- (NSString *)getAnswerSDP:(RBVideoInfoSession *)section SDP:(NSString *)sdp;

- (NSString *)getOfferSDP:(RBVideoInfoSession *)section  SDP:(NSString *)sdp;

- (NSString *)getCandidate:(RBVideoInfoSession *)section  IceCandidate:(RTCICECandidate *)candidate;
- (NSString *)getBye:(RBVideoInfoSession *)section;

- (NSString *)getMute:(RBVideoInfoSession *)section VideoEnable:(BOOL)videoEnable AudioEnable:(BOOL)audio;

- (NSString *)getHeatbeat;

- (RBMsgBaseModle *)parseModle:(NSString *)jsonString;


@end
