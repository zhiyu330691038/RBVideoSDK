//
//  NSURLConnection+Handle.h
//  JuanRoobo
//
//  Created by Zhi Kuiyu on 15/10/17.
//  Copyright © 2015年 Zhi Kuiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (Handle)
+ (void)sendAsynchronousRequest:(NSURLRequest *)request
                completionBlock:(void (^)(NSData *data,
                                          NSError *error))completionHandler;
@end
