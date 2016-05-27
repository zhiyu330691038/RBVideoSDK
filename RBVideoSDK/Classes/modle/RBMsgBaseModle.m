//
//  RBMsgBaseModle.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBMsgBaseModle.h"

@implementation RBMsgBaseModle

NSMutableDictionary * msgType ;

- (instancetype)initWithType:(NSString *)type{
    if(self = [super init]){
        self.type = type;
    }
    return self;
}


- (NSString *)dealMessage{
    return nil;
}

+ (RBMsgBaseModle *)parse:(NSDictionary *)dict{
    NSString * type = [dict objectForKey:@"type"];
    if([type length] > 0){
        Class classa = [msgType objectForKey:type];
        RBMsgBaseModle * modle = [(RBMsgBaseModle *)[classa alloc] initWithDict:dict];
        return modle;
    }
    
    return nil;
}

+ (void)registerSubtype:(Class)classtype Type:(NSString *)type{
    if(msgType == nil){
        msgType = [[NSMutableDictionary alloc] init];
    }
    if([classtype isSubclassOfClass:[RBMsgBaseModle class]]){
        [msgType setObject:classtype forKey:type];
    }
}


@end
