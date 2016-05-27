//
//  RBComet.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBCometClient.h"


@interface RBComet : NSObject

@property(nonatomic,weak) id<RBCometClient> delegate;


- (void)sendMessage:(NSString *)message;

- (void)connect:(NSString *)url;;

- (void)close;
@end
