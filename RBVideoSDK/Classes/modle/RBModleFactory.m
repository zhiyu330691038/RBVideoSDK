//
//  RBModleFactory.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBModleFactory.h"
#import "RBVideoCredential.h"
#import "RBLoginModle.h"
#include "UIDevice+Hardwares.h"
#import "RBSdkVersion.h"
#import <objc/message.h>
#import "RBBodyModle.h"
#import "RTCICECandidate.h"
#import "RBCallMsgModel.h"
#import "RBVideoInfoSession.h"
#import "RBVideoCallDelegate.h"
#import "RBHeatbeatModel.h"
#import "RBLoginAckModel.h"
#import "RBHeatbeatAckModel.h"
#import "RBCallMsgServAckModel.h"
#import "RBBodyBaseModle.h"
#import "RBVideoEvent.h"
#import "RTCSessionDescription.h"

@implementation RBModleFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        [RBMsgBaseModle registerSubtype:[RBLoginAckModel class] Type:MODEL_LOGINACK];
        [RBMsgBaseModle registerSubtype:[RBCallMsgModel class] Type:MODEL_CALLMESSAGE];
        [RBMsgBaseModle registerSubtype:[RBHeatbeatModel class] Type:MODEL_HEATBAT];
        [RBMsgBaseModle registerSubtype:[RBHeatbeatAckModel class] Type:MODEL_HEATBATACK];
        [RBMsgBaseModle registerSubtype:[RBCallMsgServAckModel class] Type:MODEL_CALLMESSAGE_SERVACK];
        
        
        [RBBodyBaseModle registerSubtype:[RBCallAckBodyModle class] Type:BODY_CALLACK];
        [RBBodyBaseModle registerSubtype:[RBIncomingCallBodyModle class] Type:BODY_CALL];
        [RBBodyBaseModle registerSubtype:[RBAnswerBodyModle class] Type:BODY_ANSWER];
        [RBBodyBaseModle registerSubtype:[RBCandidateBodyModle class] Type:BODY_CANDI];
        [RBBodyBaseModle registerSubtype:[RBOfferBodyModle class] Type:BODY_OFFER];
        [RBBodyBaseModle registerSubtype:[RBMuteBodyModle class] Type:BODY_MUTE];
        [RBBodyBaseModle registerSubtype:[RBByeBodyModle class] Type:BODY_BYE];
    }
    return self;
}

- (void)setLoginParam:(RBVideoCredential *)param{
    _loginModle = [[RBLoginModle alloc] init];
    _loginModle.userid = param.userId;
    _loginModle.pwd = param.password;
    _loginModle.token = param.token;
    _loginModle.usertype =  @"user";
    _loginModle.os = @"ios";
    _loginModle.os_version =  [UIDevice systemVersion];
    _loginModle.device =  [[UIDevice currentDevice] hardwareDescription];
    _loginModle.sdk_version = SDKVERSION;
    _loginModle.appkey = param.appkey;
    _loginModle.appid = param.appid;
    NSString * version = [NSString stringWithFormat:@"%@_build:%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    _loginModle.app_version = version;
    _loginModle.model = [[NSBundle mainBundle] bundleIdentifier];
    
}

- (NSDictionary *)jsonToObject:(NSString *)jsonString{

    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict =
    [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error.localizedDescription);
    }
    if([dict isKindOfClass:[NSDictionary class]]){
        return dict;
    }
    return nil;
}

#pragma mark - parse modle

- (RBMsgBaseModle *)parseModle:(NSString *)jsonString{
    NSDictionary * dict = [self jsonToObject:jsonString];
    NSString * msgType = [dict objectForKey:@"type"];
    if(msgType == nil)
        return nil;
    
    RBMsgBaseModle * msgModle = [RBMsgBaseModle parse:dict];
    [msgModle dealMessage];
    return msgModle;

}

#pragma mark - make modle

- (RBCallMsgModel *)getCallMsgModle:(RBVideoInfoSession *)section{
    RBCallMsgModel * callmsgmodle = [[RBCallMsgModel alloc] init];
    callmsgmodle.from = _loginModle.userid;
    callmsgmodle.to = section.mUserID;
    callmsgmodle.msgid =  [RBVideoInfoSession createMessageID];
    return callmsgmodle;
}

- (NSString *)getCallModle:(RBVideoInfoSession *)section{
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBIncomingCallBodyModle * body = [[RBIncomingCallBodyModle alloc] init];
    body.sid = section.mSessionID;
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getCallResponse:(RBVideoInfoSession *)section CallState:(CallState) callstate{
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBCallAckBodyModle * body = [[RBCallAckBodyModle alloc] init];
    body.status = [NSString stringWithFormat:@"%ld",(long)callstate];
    body.sid = section.mSessionID;
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getAnswerSDP:(RBVideoInfoSession *)section SDP:(NSString *)sdp{
    
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBAnswerBodyModle * body = [[RBAnswerBodyModle alloc] init];
    body.sid = section.mSessionID;
    body.sdp = sdp;
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getOfferSDP:(RBVideoInfoSession *)section  SDP:(NSString *)sdp{
    
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBOfferBodyModle * body = [[RBOfferBodyModle alloc] init];
    body.sid = section.mSessionID;
    body.sdp = sdp;
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getCandidate:(RBVideoInfoSession *)section  IceCandidate:(RTCICECandidate *)candidate{
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBCandidateBodyModle * body = [[RBCandidateBodyModle alloc] init];
    body.sid = section.mSessionID;
    body.lable = [NSNumber numberWithInteger:candidate.sdpMLineIndex];
    body.cid = candidate.sdpMid;
    body.candidate = candidate.sdp;
    modle.body = body;
    return modle.toJSON;
}
- (NSString *)getBye:(RBVideoInfoSession *)section{
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBByeBodyModle * body = [[RBByeBodyModle alloc] init];
    body.sid = section.mSessionID;
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getMute:(RBVideoInfoSession *)section VideoEnable:(BOOL)videoEnable AudioEnable:(BOOL)audio{
    
    RBCallMsgModel * modle = [self getCallMsgModle:section];
    RBMuteBodyModle * body = [[RBMuteBodyModle alloc] init];
    body.sid = section.mSessionID;
    body.audio = [NSNumber numberWithBool:audio];
    body.video = [NSNumber numberWithBool:videoEnable];
    modle.body = body;
    return modle.toJSON;
}

- (NSString *)getHeatbeat{
    RBHeatbeatModel * modle = [[RBHeatbeatModel alloc] init];
    return modle.toJSON;
}

#pragma mark - dispose Message
- (void)disposeHeatbeatMessage:(RBHeatbeatAckModel *)modle{
    [self.delegate onHeatBeatAck:[modle.status isEqualToString:@"online"]];
}

- (void)disposeLoginMessage:(RBLoginAckModel *)modle{
    Boolean isScuess = NO;
    NSString *reasion = nil;
    VideoEvent code = EVENT_LOGIN_UNKOWN;
    if([modle.status isEqualToString:@"ok"]){
        isScuess = YES;
        code = EVENT_LOGIN_INFO_SCUESS;
    }else if([modle.status isEqualToString:@"invalid"]){
        reasion = @"token invalid";
        code = EVENT_LOGIN_INFO_TOKEN_INVALID;
    }else{
        reasion = modle.reason;
    }
    [self.delegate onLoginResult:isScuess Event:code Reason:reasion];
}

- (void)disposeCallMsgServAskMessage:(RBCallMsgServAckModel *)modle{
    if([modle.status isEqualToString:@"ok"]){
        return;
    }
    int error;
    if([modle.status isEqualToString:@"offline"]){
        error = VIDEO_ERROR_OFFLINE;
    }else if([modle.status isEqualToString:@"offline"]){
        error = VIDEO_ERROR_PERMISSION;
    }else{
        error = VIDEO_ERROR_SERVER;
    }
    [self.delegate onVideoControlEvent:EVENT_REJECTCALL VideoSecssion:nil ErrorCode:error Reason:nil];
}

#pragma mark - dispose call


- (void)disposeCallAck:(NSString *) from :(RBCallAckBodyModle *)modle{
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];

    VideoEvent error;
    int  event;
    
    if([modle.status isEqualToString:@"accept"]){
        event = EVENT_ACCEPTCALL;
    }else{
        event = EVENT_REJECTCALL;
    }

    [self.delegate onVideoControlEvent:event VideoSecssion:section ErrorCode:error Reason:nil];
    
}

- (void)disposeCallAnswer:(NSString *) from :(RBAnswerBodyModle *)modle{
    RTCSessionDescription * sdp =  [[RTCSessionDescription alloc] initWithType:modle.type sdp:modle.sdp];
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];
    [self.delegate onVideoControlEvent:EVENT_SDP VideoSecssion:section ErrorCode:0 Reason:sdp];
    
}

- (void)disposeCallOfferBody:(NSString *) from :(RBOfferBodyModle *)modle{
    RTCSessionDescription * sdp =  [[RTCSessionDescription alloc] initWithType:modle.type sdp:modle.sdp];
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];
    [self.delegate onVideoControlEvent:EVENT_SDP VideoSecssion:section ErrorCode:0 Reason:sdp];
    
}

- (void)disposeCallMuteBody:(NSString *) from :(RBMuteBodyModle *)modle{
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];
    [self.delegate onVideoControlEvent:EVENT_MUTE VideoSecssion:section ErrorCode:[modle.audio boolValue] Reason:modle.video];
    
}

- (void)disposeCallCandidateBody:(NSString *) from :(RBCandidateBodyModle *)modle{
    RTCICECandidate * candidate =  [[RTCICECandidate alloc] initWithMid:modle.cid index:[modle.lable intValue] sdp:modle.candidate];
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];
    [self.delegate onVideoControlEvent:EVENT_ICE VideoSecssion:section ErrorCode:0 Reason:candidate];
    
}

- (void)disposeCallByeBody:(NSString *) from :(RBByeBodyModle *)modle{
    RBVideoInfoSession * section = [RBVideoInfoSession videoSession:from Sid:modle.sid];
    [self.delegate onVideoControlEvent:EVENT_ENDCALL VideoSecssion:section ErrorCode:0 Reason:nil];
    
}

#pragma mark - RBIModleDeal

- (void)dealMessage:(RBBaseModle *)modle{

    if([modle isKindOfClass:[RBLoginAckModel class]]){
        [self disposeLoginMessage:(RBLoginAckModel *)modle];
    }else if([modle isKindOfClass:[RBHeatbeatAckModel class]]){
        [self disposeHeatbeatMessage:(RBHeatbeatAckModel *)modle];
    }else if([modle isKindOfClass:[RBCallMsgServAckModel class]]){
        [self disposeCallMsgServAskMessage:(RBCallMsgServAckModel *)modle];
    }
}

- (void)dealCall:(NSString *) from :(RBBaseModle *)modle{
    if([modle isKindOfClass:[RBCallAckBodyModle class]]){
        [self disposeCallAck:from :(RBCallAckBodyModle *)modle];
    }else if([modle isKindOfClass:[RBAnswerBodyModle class]]){
        [self disposeCallAnswer:from :(RBAnswerBodyModle *)modle];
    }else if([modle isKindOfClass:[RBOfferBodyModle class]]){
        [self disposeCallOfferBody:from :(RBOfferBodyModle *)modle];
    }else if([modle isKindOfClass:[RBMuteBodyModle class]]){
        [self disposeCallMuteBody:from :(RBMuteBodyModle *)modle];
    }else if([modle isKindOfClass:[RBCandidateBodyModle class]]){
        [self disposeCallCandidateBody:from :(RBCandidateBodyModle *)modle];
    }else if([modle isKindOfClass:[RBByeBodyModle class]]){
        [self disposeCallByeBody:from :(RBByeBodyModle *)modle];
    }
}



@end
