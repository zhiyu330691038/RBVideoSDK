//
//  RBLoginModle.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBMsgBaseModle.h"

@interface RBLoginModle : RBMsgBaseModle
@property(nonatomic,strong) NSString * userid;
@property(nonatomic,strong) NSString * pwd;
@property(nonatomic,strong) NSString * v;
@property(nonatomic,strong) NSString * token;
@property(nonatomic,strong) NSString * usertype;
@property(nonatomic,strong) NSString * os;
@property(nonatomic,strong) NSString * os_version;
@property(nonatomic,strong) NSString * device;
@property(nonatomic,strong) NSString * sdk_version;
@property(nonatomic,strong) NSString * appkey;
@property(nonatomic,strong) NSString * appid;
@property(nonatomic,strong) NSString * model;
@property(nonatomic,strong) NSString * app_version;

@end
