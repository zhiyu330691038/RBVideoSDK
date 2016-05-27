//
//  RBCallMsgServAckModel.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBCallMsgServAckModel.h"

@implementation RBCallMsgServAckModel
-(NSString *)type{
    return MODEL_CALLMESSAGE_SERVACK;
}


-(NSString *)dealMessage{
    [self.dealDelegate dealMessage:self];
    return NULL;
}
@end
