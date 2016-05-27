//
//  RBHeatbeatModel.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBHeatbeatModel.h"

@implementation RBHeatbeatModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = MODEL_HEATBAT;
    }
    return self;
}

- (NSString *)dealMessage{
    [self.dealDelegate dealMessage:self];
    return Nil;
}
@end
