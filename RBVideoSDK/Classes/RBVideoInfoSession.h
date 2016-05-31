//
//  RBVideoInfoSection.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/17.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBVideoInfoSession : NSObject

@property(nonatomic,strong) NSString * mUserID;

@property(nonatomic,strong) NSString * mSessionID;

+ (RBVideoInfoSession *)videoSession:(NSString *)userId;

+ (RBVideoInfoSession *)videoSession:(NSString *)userId Sid:(NSString *)sid;

+ (NSNumber *)createMessageID;
@end
