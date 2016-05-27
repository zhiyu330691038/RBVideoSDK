//
//  RBTurnServer.m
//  video
//
//  Created by Zhi Kuiyu on 16/5/20.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBTurnServer.h"
#import "NSURLConnection+Handle.h"
#import "RTCICEServer.h"

@implementation RBTurnServer
static NSString *kTURNOriginURLString = @"https://apprtc.appspot.com";
static NSString *kARDCEODTURNClientErrorDomain = @"ARDCEODTURNClient";
static NSInteger kARDCEODTURNClientErrorBadResponse = -1;


+ (RBTurnServer *)create:(NSString *)addurl{
    RBTurnServer * a = [[RBTurnServer alloc] init];
    a.mUrl = addurl;
    return a;

}


- (void)connect:(void (^)(NSArray *turnServers,NSError *error))completionHandler{
    NSString * urlString = nil;
    if([_mUrl hasPrefix:@"wss"]){
        urlString = [_mUrl stringByReplacingOccurrencesOfString:@"wss" withString:@"https"];
    }else if([_mUrl hasSuffix:@"ws:"])
        [urlString stringByReplacingOccurrencesOfString:@"ws:" withString:@"http:"];
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"ws" withString:@""];
    urlString = [urlString stringByAppendingString:@"turn?username=iosapprtc&key=hi.roobo"];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    if(url == nil && urlString == nil){
        if(completionHandler){
            completionHandler(nil,[NSError errorWithDomain:@"url 为空" code:10000 userInfo:nil]);
            return;
        }
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"Mozilla/5.0" forHTTPHeaderField:@"user-agent"];
    [request addValue:kTURNOriginURLString forHTTPHeaderField:@"origin"];
    
    
    [NSURLConnection sendAsynchronousRequest:request completionBlock:^(NSData *data, NSError *error) {
        NSArray *turnServers = [NSArray array];
        if (error) {
            /* 请求失败 */
            completionHandler(turnServers, error);
            return;
        }
        /* 解析json服务器地址数据 */
        NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        turnServers = [RBTurnServer serversFromCEODJSONDictionary:dict];
        
        if (!turnServers) {
            NSError *responseError =
            [[NSError alloc] initWithDomain:kARDCEODTURNClientErrorDomain
                                       code:kARDCEODTURNClientErrorBadResponse
                                   userInfo:@{
                                              NSLocalizedDescriptionKey: @"Bad TURN response.",
                                              }];
            completionHandler(turnServers, responseError);
            return;
        }
        /* 完成turn服务器地址请求 */
        completionHandler(turnServers, nil);
    }];

}
static NSString const *kRTCICEServerUsernameKey = @"username";
static NSString const *kRTCICEServerPasswordKey = @"password";
static NSString const *kRTCICEServerUrisKey = @"uris";
static NSString const *kRTCICEServerUrlKey = @"urls";
static NSString const *kRTCICEServerCredentialKey = @"credential";
+ (NSArray *)serversFromCEODJSONDictionary:(NSDictionary *)dictionary {
    NSString *username = dictionary[kRTCICEServerUsernameKey];
    NSString *password = dictionary[kRTCICEServerPasswordKey];
    NSArray *uris = dictionary[kRTCICEServerUrisKey];
    NSMutableArray *servers = [NSMutableArray arrayWithCapacity:uris.count];
    for (NSString *uri in uris) {
        RTCICEServer *server =
        [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:uri]
                                 username:username
                                 password:password];
        [servers addObject:server];
    }
    return servers;
}
@end
