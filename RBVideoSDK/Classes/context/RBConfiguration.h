//
//  Configuration.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  video codec
 */
UIKIT_EXTERN  NSString * VIDEO_CODEC_VP8;
UIKIT_EXTERN  NSString * VIDEO_CODEC_VP9;
UIKIT_EXTERN  NSString * VIDEO_CODEC_H264;

/**
 *  audio codec
 */
UIKIT_EXTERN  NSString * AUDIO_CODEC_OPUS;
UIKIT_EXTERN  NSString * AUDIO_CODEC_ISAC;

/*
 *   fields
 */
UIKIT_EXTERN  NSString * FIELD_MAX_HEIGHT;
UIKIT_EXTERN  NSString * FIELD_MAX_WIDTH;
UIKIT_EXTERN  NSString * FIELD_MAX_FPS;
UIKIT_EXTERN  NSString * FIELD_MIN_FPS;


UIKIT_EXTERN  NSString * FIELD_VIDEO_CODEC;
UIKIT_EXTERN  NSString * FIELD_AUDIO_CODEC;
UIKIT_EXTERN  NSString * FIELD_HW_CODEC;
UIKIT_EXTERN  NSString * FIELD_LOOPBACK;
UIKIT_EXTERN  NSString * FIELD_VIDEO_FPS;
UIKIT_EXTERN  NSString * FIELD_MEDIA_PROCESSING;
UIKIT_EXTERN  NSString * FIELD_AUDIO_BITRATE;
UIKIT_EXTERN  NSString * FIELD_VIDEO_BITRATE;
UIKIT_EXTERN  NSString * FIELE_ENABLE_REMOTEVIDEO;

/*
 *   default capability
 */
UIKIT_EXTERN   BOOL DEFAULT_HW_CODEC;
UIKIT_EXTERN   BOOL DEFAULT_LOOPBACK;
UIKIT_EXTERN   BOOL DEFAULT_MEDIA_PROCESSING;

UIKIT_EXTERN   int DEFAULT_AUDIO_BITRATE;
UIKIT_EXTERN   int DEFAULT_VIDEO_BITRATE;

UIKIT_EXTERN   int MAX_VIDEO_FPS;
UIKIT_EXTERN   int MAX_VIDEO_WIDTH;
UIKIT_EXTERN   int MAX_VIDEO_HEIGHT;
UIKIT_EXTERN   int MIN_VIDEO_WIDTH;
UIKIT_EXTERN   int MIN_VIDEO_HEIGHT;


@interface RBConfiguration : NSObject


@property (nonatomic,strong) NSMutableDictionary * config;

- (void)setValue:(NSObject *)value forkey:(NSString *)key;

- (id)valueForkey:(NSString *)key;




@end

