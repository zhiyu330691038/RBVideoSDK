//
//  RBHeatbeatAckModel.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBHeatbeatAckModel.h"

@implementation RBHeatbeatAckModel

- (NSString *)type{
    return MODEL_HEATBATACK;
}



- (NSString *)dealMessage{
    [self.dealDelegate dealMessage:self];
    return nil;
}
@end
