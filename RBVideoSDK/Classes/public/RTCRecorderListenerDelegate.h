//
//  RTCRecorderListenerDelegate.m
//  sources_for_indexing
//
//  Created by tcp china on 16/3/15.
//
//

#import <Foundation/Foundation.h>


@protocol RTCRecorderListenerDelegate<NSObject>

- (void)notify:(int )Msg Ext:(int)Ext;


@optional


@end