//
//  RBCallMsgModel.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBMsgBaseModle.h"
@class RBVideoInfoSession;
@class RBBodyBaseModle;

@interface RBCallMsgModel : RBMsgBaseModle

@property(nonatomic,strong) NSString * from;
@property(nonatomic,strong) NSString * to;
@property(nonatomic,strong) NSNumber * msgid;
@property(nonatomic,strong) NSString * v;
@property(nonatomic,strong) RBBodyBaseModle * body;

@end
