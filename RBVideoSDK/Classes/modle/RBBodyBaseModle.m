//
//  RBBodyBaseModle.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBodyBaseModle.h"

@implementation RBBodyBaseModle
- (void)deal:(id<RBIModleDeal>) deal From:(NSString *)from{

}

NSMutableDictionary * bodyType ;
+ (RBBodyBaseModle *)parse:(NSDictionary *)dict{
    NSString * type = [dict objectForKey:@"type"];
    if([type length] > 0){
        Class classa = [bodyType objectForKey:type];
        RBBodyBaseModle * modle = [(RBBodyBaseModle *)[classa alloc] initWithDict:dict];
        return modle;
    }
    
    return nil;
}

+ (void)registerSubtype:(Class)classtype Type:(NSString *)type{
    if(bodyType == nil){
        bodyType = [[NSMutableDictionary alloc] init];
    }
    if([classtype isSubclassOfClass:[RBBodyBaseModle class]]){
        [bodyType setObject:classtype forKey:type];
    }
}


@end
