//
//  RBVideoAddress.h
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#ifndef RBVideoAddress_h
#define RBVideoAddress_h
#import <Foundation/Foundation.h>

@interface RBVideoAddress : NSObject

@property(nonatomic,strong) NSString * urlString;

@property(nonatomic,readonly) NSURL    * url;

+ (RBVideoAddress *)videoAddressWithURL:(NSString *)url;



@end

#endif /* RBVideoAddress_h */
