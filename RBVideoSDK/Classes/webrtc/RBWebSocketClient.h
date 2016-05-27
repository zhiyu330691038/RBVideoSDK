//
//  RBWebSocketClient.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/18.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBCometClient.h"
#import "SRWebSocket.h"
@interface RBWebSocketClient : NSObject<SRWebSocketDelegate>

@property(nonatomic,weak) id<RBCometClient> delegate;

@property(nonatomic,strong,readonly) NSString * socketURL;

@property(nonatomic,strong,readonly) SRWebSocket * webSocket;

- (void)sendMessage:(NSString *)message;

- (void)connect:(NSString *)url;;

- (void)close;


@end
