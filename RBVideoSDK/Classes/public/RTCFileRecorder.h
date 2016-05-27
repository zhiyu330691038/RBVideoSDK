//
//  RTCFileRecorder.h
//  sources_for_indexing
//
//  Created by tcp china on 16/3/14.
//
//

#ifndef RTCFileRecorder_h
#define RTCFileRecorder_h
#import "RTCRecorderListenerDelegate.h"

#import <Foundation/Foundation.h>

// RTCAudioSource is an ObjectiveC wrapper for AudioSourceInterface.  It is
// used as the source for one or more RTCAudioTrack objects.
@interface RTCFileRecorder : NSObject

- (id)initWithFileRecorder:(id<RTCRecorderListenerDelegate> )delegate;
-(void)StartRecording:(NSString*)file;
-(void)StopRecording;
-(void)free;


#ifndef DOXYGEN_SHOULD_SKIP_THIS
// Disallow init and don't add to documentation
- (id)init __attribute__(
                         (unavailable("init is not a supported initializer for this class.")));
#endif /* DOXYGEN_SHOULD_SKIP_THIS */

@end

#endif /* RTCFileRecorder_h */
