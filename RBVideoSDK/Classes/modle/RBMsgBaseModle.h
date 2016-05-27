//
//  RBMsgBaseModle.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/19.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBBaseModle.h"
#import "RBIModleDeal.h"
@interface RBMsgBaseModle : RBBaseModle




@property(nonatomic,strong) NSString * type;


@property(nonatomic,weak) id<RBIModleDeal> dealDelegate;

- (instancetype)initWithType:(NSString *)type;


- (NSString *)dealMessage;


+ (RBMsgBaseModle *)parse:(NSDictionary *)dict;

+ (void)registerSubtype:(Class)classtype Type:(NSString *)type;

@end
