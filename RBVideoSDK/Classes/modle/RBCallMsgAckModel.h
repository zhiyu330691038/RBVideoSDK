//
//  RBCallMsgAckModel.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBMsgBaseModle.h"

@interface RBCallMsgAckModel : RBMsgBaseModle

@property(nonatomic,strong) NSNumber * msgid;

@property(nonatomic,strong) NSString * status;

@property(nonatomic,strong) NSString * from;

@end
