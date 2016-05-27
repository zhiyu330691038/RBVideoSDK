//
//  RBCometClient.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RBCometClient <NSObject>

- (void)onMessage:(NSString*)message;

- (void)onOpened;

- (void)onClose;

- (void)onError;

@end
