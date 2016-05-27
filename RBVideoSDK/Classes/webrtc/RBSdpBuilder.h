//
//  RBSdpBuilder.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/24.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTCSessionDescription.h"

@interface RBSdpBuilder : NSObject
+ (RTCSessionDescription *)
descriptionForDescription:(RTCSessionDescription *)description
preferredVideoCodec:(NSString *)codec;
@end
