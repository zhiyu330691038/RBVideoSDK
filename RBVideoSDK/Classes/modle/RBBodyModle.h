//
//  RBBodyModle.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBodyBaseModle.h"

@interface RBAnswerBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * sdp;

@end


@interface RBIncomingCallBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * ticket;


@end


@interface RBCallAckBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * status;
@property(nonatomic,strong) NSString * reason;


@end


@interface RBOfferBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * sdp;

@end



@interface RBCandidateBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * candidate;

@property(nonatomic,strong) NSNumber * lable;

@property(nonatomic,strong) NSString * cid;


@end

@interface RBByeBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSString * sdp;

@end

@interface RBMuteBodyModle : RBBodyBaseModle

@property(nonatomic,strong) NSNumber * video;

@property(nonatomic,strong) NSNumber * audio;


@end

