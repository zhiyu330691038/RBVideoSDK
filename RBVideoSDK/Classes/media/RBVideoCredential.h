//
//  RBVideoCredential.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoCredential_h
#define RBVideoCredential_h

#import <Foundation/Foundation.h>

@interface RBVideoCredential : NSObject

/**
 *  @author 智奎宇, 16-05-18 12:05:10
 *
 *  用户APP用户的登陆 TOKEN
 */
@property(nonatomic,strong) NSString * token;

/**
 *  @author 智奎宇, 16-05-18 12:05:41
 *
 *  用户APP用户登陆信息的 用户id userid
 */
@property(nonatomic,strong) NSString * userId;

/**
 *  @author 智奎宇, 16-05-18 12:05:17
 *
 *  视频的加入密码
 */
@property(nonatomic,strong) NSString * password;

/**
 *  @author 智奎宇, 16-05-18 15:05:42
 *
 *  要观看视频的id，布丁id
 */
@property(nonatomic,strong) NSString * videoClientId;
/**
 *  @author 智奎宇, 16-05-18 17:05:32
 *
 *  客户端的appkey  以后上线
 */
@property(nonatomic,strong) NSString * appkey;

/**
 *  @author 智奎宇, 16-05-18 17:05:49
 *
 *  客户端的appid
 */
@property(nonatomic,strong) NSString * appid;
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
- (instancetype)initWithUserId:(NSString *)userid PassWord:(NSString *)password UserToken:(NSString*)token;

@end


#endif /* RBVideoCredential_h */
