//
//  RBVideoPeer.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoPeer.h"

@implementation RBVideoPeer


+ (RBVideoPeer *)videoPeerWithUserID:(NSString *)userID{
    RBVideoPeer * peer = [[RBVideoPeer alloc] init];
    peer.userId = userID;
    return peer;
}

@end
