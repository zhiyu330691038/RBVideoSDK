//
//  RBVideoPeer.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoPeer_h
#define RBVideoPeer_h
#import <Foundation/Foundation.h>

@interface RBVideoPeer : NSObject

@property(nonatomic,strong) NSString * userId;

+ (RBVideoPeer *)videoPeerWithUserID:(NSString *)userID;

@end


#endif /* RBVideoPeer_h */
