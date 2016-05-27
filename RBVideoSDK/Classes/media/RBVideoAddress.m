//
//  RBVideoAddress.m
//  video
//
//  Created by tcp china on 16/3/27.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import "RBVideoAddress.h"

@implementation RBVideoAddress

+ (RBVideoAddress *)videoAddressWithURL:(NSString *)url{

    RBVideoAddress * address = [[RBVideoAddress alloc] init];
    address.urlString = url;
    return address;

}

- (NSURL *)url{

    return [NSURL URLWithString:_urlString];
}
@end
