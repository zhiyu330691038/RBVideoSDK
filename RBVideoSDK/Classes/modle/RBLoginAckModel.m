//
//  RBLoginAckModel.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBLoginAckModel.h"

@implementation RBLoginAckModel

- (NSString *)type{
    return MODEL_LOGINACK;
}


-(NSString *)dealMessage{

    [self.dealDelegate dealMessage:self];
    return nil;
}
@end
