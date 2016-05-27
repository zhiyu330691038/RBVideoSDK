//
//  Configuration.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//
#import "RBConfiguration.h"
/**
 *  video codec
 */
NSString *VIDEO_CODEC_VP8 = @"VP8";
NSString *VIDEO_CODEC_VP9 = @"VP9";
NSString *VIDEO_CODEC_H264 = @"H264";

/**
 *  audio codec
 */
NSString *AUDIO_CODEC_OPUS = @"opus";
NSString *AUDIO_CODEC_ISAC = @"ISAC";

/*
 *   fields
 */
NSString *FIELD_MAX_HEIGHT = @"maxHeight";
NSString *FIELD_MAX_WIDTH = @"maxWidth";
NSString *FIELD_MAX_FPS = @"maxFps";
NSString *FIELD_MIN_FPS = @"minFps";

NSString *FIELD_VIDEO_CODEC = @"videoCodec";
NSString *FIELD_AUDIO_CODEC = @"audioCodec";
NSString *FIELD_HW_CODEC = @"hwCodec";
NSString *FIELD_LOOPBACK = @"loopback";
NSString *FIELD_VIDEO_FPS = @"videoFps";
NSString *FIELD_MEDIA_PROCESSING = @"mediaProcessing";
NSString *FIELD_AUDIO_BITRATE = @"audioStartBitrate";
NSString *FIELD_VIDEO_BITRATE = @"videoStartBitrate";
NSString *FIELE_ENABLE_REMOTEVIDEO = @"enableRemoteVideo";

/*
 *   default capability
 */
BOOL DEFAULT_HW_CODEC = true;
BOOL DEFAULT_LOOPBACK = false;
BOOL DEFAULT_MEDIA_PROCESSING = false;

int DEFAULT_AUDIO_BITRATE = 0;
int DEFAULT_VIDEO_BITRATE = 0;

int MAX_VIDEO_FPS = 30;
int MAX_VIDEO_WIDTH = 1280;
int MAX_VIDEO_HEIGHT = 720;
int MIN_VIDEO_WIDTH = 640;
int MIN_VIDEO_HEIGHT = 480;

@implementation RBConfiguration

- (NSMutableDictionary *)config{
    if(_config == nil){
        _config = [NSMutableDictionary new];
    }
    
    return _config;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setValue:(NSObject *)value forkey:(NSString *)key{
    if(value == nil || key == nil){
        NSLog(@"设置配置文件失败");
        return;
    }
    [self.config setObject:value forKey:key];


}

- (id)valueForkey:(NSString *)key{
    return [self.config objectForKey:key];
}



@end