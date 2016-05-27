//
//  RBCallMsgServAckModel.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBMsgBaseModle.h"

@interface RBCallMsgServAckModel : RBMsgBaseModle

@property(nonatomic,strong) NSString * status;

@property(nonatomic,strong) NSString * reason;

@property(nonatomic,strong) NSString * msgid;

@end
