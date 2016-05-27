//
//  RBVideoCredential.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoCredential.h"

@implementation RBVideoCredential

/**
 *  @author 智奎宇, 16-05-18 12:05:44
 *
 *  实例化视频认证信息的modle
 *
 *  @param userid   用户id
 *  @param password 视频的密码
 *  @param tokdn    用户token
 *
 */
- (instancetype)initWithUserId:(NSString *)userid PassWord:(NSString *)password UserToken:(NSString*)token{

    if(self = [super init]){
    
        self.token = token;
        self.password = password;
        self.userId = userid;
    
    }

    return self;

}

@end