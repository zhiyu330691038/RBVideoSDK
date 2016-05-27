//
//  RBIModleDeal.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RBBaseModle;

@protocol RBIModleDeal <NSObject>

- (void)dealMessage:(RBBaseModle *)headbeat;

- (void)dealCall:(NSString *) from :(RBBaseModle *)modle;

@end
