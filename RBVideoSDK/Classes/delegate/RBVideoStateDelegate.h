//
//  RBVideoStateDelegate.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/23.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RBVideoInfoSession;
@protocol RBVideoStateDelegate <NSObject>

- (void)onVideoError:(RBVideoInfoSession *)setcion ErrorCode:(int)errorCode ErrorMsg:(NSString *)errMsg;

- (void)onCallConnected:(RBVideoInfoSession *)setcion;


- (void)onCallHungup:(RBVideoInfoSession *)setcion;

@end
