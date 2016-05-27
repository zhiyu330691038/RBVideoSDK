//
//  RBBodyModle.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBodyModle.h"

@implementation RBAnswerBodyModle

- (NSString *)type{
    return BODY_ANSWER;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}
@end


@implementation RBIncomingCallBodyModle

- (NSString *)type{
    return BODY_CALL;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}

@end

@implementation RBCallAckBodyModle

- (NSString *)type{
    return BODY_CALLACK;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}

@end


@implementation RBOfferBodyModle

- (NSString *)type{
    return BODY_OFFER;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}
@end

@implementation RBCandidateBodyModle


- (NSString *)type{
    return BODY_CANDI;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}

- (NSDictionary *)toDict{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[super toDict]];
    NSString * cid = [dict objectForKey:@"cid"];
    [dict removeObjectForKey:@"cid"];
    [dict setObject:cid forKey:@"id"];
    return dict;
    
}

@end

@implementation RBByeBodyModle

- (NSString *)type{
    return BODY_BYE;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}
@end

@implementation RBMuteBodyModle

- (NSString *)type{
    return BODY_MUTE;
}


-(void)deal:(id<RBIModleDeal>)deal From:(NSString *)from{
    [deal dealCall:from :self];
}

@end

