//
//  RBVideoInfoSection.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/17.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoInfoSession.h"

@implementation RBVideoInfoSession

+ (RBVideoInfoSession *)videoSession:(NSString *)userId{
    RBVideoInfoSession * session = [[RBVideoInfoSession alloc] init];
    session.mSessionID = [RBVideoInfoSession getSessionID];
    session.mUserID = userId;
    
    return session;
}


+ (RBVideoInfoSession *)videoSession:(NSString *)userId Sid:(NSString *)sid{
    RBVideoInfoSession * session = [[RBVideoInfoSession alloc] init];
    session.mSessionID = sid;
    session.mUserID = userId;
    
    return session;
}
+ (NSString *)getSessionID{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if(uuid.length < 16){
        return  @"uuiderrorerror11";
    }
    
    return [[uuid lowercaseString] substringToIndex:16];
    
}

+ (NSNumber *)createMessageID{
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString * str = [NSString stringWithFormat:@"%.10f",time];
    str = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    return [NSNumber numberWithLong:[[str substringToIndex:16] longLongValue]];
    
}

@end
