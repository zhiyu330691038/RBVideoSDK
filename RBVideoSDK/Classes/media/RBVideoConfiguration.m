//
//  RBVideoConfiguration.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoConfiguration.h"
#import "RBConfiguration.h"

@interface RBVideoConfiguration(){
    RBConfiguration * config;

}

@end


@implementation RBVideoConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        config = [[RBConfiguration alloc] init];
        
    }
    return self;
}


- (void)setVideoSize:(float)width Height:(float )height{
    [self setVideoSize:width Height:height FPS:18];
    
}

- (void)setVideoSize:(float)width Height:(float )height FPS:(int)fps{
    
    [config.config setObject:@(width) forKey:FIELD_MAX_WIDTH];
    [config.config setObject:@(width) forKey:FIELD_MAX_WIDTH];
    [config.config setObject:@(fps) forKey:FIELD_MAX_FPS];
    
}
@end
