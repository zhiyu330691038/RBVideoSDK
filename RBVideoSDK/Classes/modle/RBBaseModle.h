//
//  RBBaseModle.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBModleConfig.h"
#import "RBIModleDeal.h"

@interface RBBaseModle : NSObject

-(instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)toDict;
- (NSString *)toJSON;




@end
