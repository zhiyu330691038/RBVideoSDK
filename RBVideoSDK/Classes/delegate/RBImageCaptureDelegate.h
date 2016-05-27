//
//  RBImageCaptureDelegate.h
//  video
//
//  Created by Zhi Kuiyu on 16/5/23.
//  Copyright © 2016年 tcp china. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RBImageCaptureDelegate <NSObject>

- (void)onCaptureResult:(UIImage *) capImage Reason:(NSString *)reason;

@end
