//
//  RBTurnServer.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTurnServer : NSObject

@property(nonatomic,strong) NSString * mUrl;

+ (RBTurnServer *)create:(NSString *)addurl;

- (void)connect:(void (^)(NSArray *turnServers,NSError *error))completionHandler;
@end
