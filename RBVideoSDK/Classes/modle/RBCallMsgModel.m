//
//  RBCallMsgModel.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBCallMsgModel.h"
#import "RBVideoInfoSession.h"
#import "RBBodyBaseModle.h"
#import "RBCallMsgAckModel.h"

@implementation RBCallMsgModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = MODEL_CALLMESSAGE;
        self.v = PROTO_VERSION;
    }
    return self;
}


- (void)setBody:(id)body{
    if([body isKindOfClass:[NSDictionary class]]){
        _body = (RBBodyBaseModle *)[RBBodyBaseModle parse:body];
    }else{
        _body = body;
    }


}
-(NSString *)dealMessage{
    [self.body deal:self.dealDelegate From:self.from];

    RBCallMsgAckModel * askModle = [[RBCallMsgAckModel alloc] init];
    askModle.from = self.to;
    askModle.msgid = self.msgid;
    return askModle.toJSON;

}

@end
