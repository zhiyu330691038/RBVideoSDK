//
//  RBBodyBaseModle.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBaseModle.h"
#import "RBIModleDeal.h"

@interface RBBodyBaseModle : RBBaseModle

@property(nonatomic,strong) NSString * type;

@property(nonatomic,strong) NSString * sid;

- (void)deal:(id<RBIModleDeal>) deal From:(NSString *)from;

+ (RBBodyBaseModle *)parse:(NSDictionary *)dict;

+ (void)registerSubtype:(Class)classtype Type:(NSString *)type;
@end
