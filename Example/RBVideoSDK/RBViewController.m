//
//  RBViewController.m
//  RBVideoSDK
//
//  Created by zhikuiyu on 05/27/2016.
//  Copyright (c) 2016 zhikuiyu. All rights reserved.
//

#import "RBViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "RBVideoClient.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import <AVFoundation/AVFoundation.h>
@interface RBViewController ()<RBVideoEventDelegate>
{
    UIButton *_stopButton;
    UIButton *_bindButton;
    UIButton *_callButton;
    UIButton *_closeButton;
    UIButton *_jiepinButton;
    UIButton *_loaudioButton;
    UIButton *_reaudioButton;
    UIButton *_luxiangButton;
    UIButton *_luxiangButtonstop;
    UIButton *lashentiancButtonstop;
    UIButton *shiyingdaxiaoButtonstop;
    UIButton *suofangtianmanButtonstop;
    
    RBVideoClient * mClient;
    UIView *_videoView;
    NSString *_user;
    NSString *_pass;
    NSString *_token;
    UITextView * logLable;
    
}
@end

@implementation RBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *controlFont = [UIFont fontWithName:@"Roboto" size:20];
    
    _bindButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _bindButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _bindButton.backgroundColor = [UIColor blueColor];
    _bindButton.layer.cornerRadius = 5;
    _bindButton.clipsToBounds = YES;
    _bindButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_bindButton setTitle:@"bind...."
                 forState:UIControlStateNormal];
    _bindButton.titleLabel.font = controlFont;
    [_bindButton setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [_bindButton setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateSelected];
    [_bindButton sizeToFit];
    [_bindButton addTarget:self
                    action:@selector(bindButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindButton];
    
    _callButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _callButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _callButton.backgroundColor = [UIColor blueColor];
    _callButton.layer.cornerRadius = 5;
    _callButton.clipsToBounds = YES;
    _callButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_callButton setTitle:@"call"
                 forState:UIControlStateNormal];
    _callButton.titleLabel.font = controlFont;
    [_callButton setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [_callButton setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateSelected];
    [_callButton sizeToFit];
    [_callButton addTarget:self
                    action:@selector(callButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_callButton];
    
    _stopButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _stopButton.backgroundColor = [UIColor blueColor];
    _stopButton.layer.cornerRadius = 5;
    _stopButton.clipsToBounds = YES;
    _stopButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_stopButton setTitle:@"stop"
                 forState:UIControlStateNormal];
    _stopButton.titleLabel.font = controlFont;
    [_stopButton setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateSelected];
    [_stopButton sizeToFit];
    [_stopButton addTarget:self
                    action:@selector(stopButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_stopButton];
    
    _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _closeButton.backgroundColor = [UIColor blueColor];
    _closeButton.layer.cornerRadius = 5;
    _closeButton.clipsToBounds = YES;
    _closeButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_closeButton setTitle:@"close"
                  forState:UIControlStateNormal];
    _closeButton.titleLabel.font = controlFont;
    [_closeButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor lightGrayColor]
                       forState:UIControlStateSelected];
    [_closeButton sizeToFit];
    [_closeButton addTarget:self
                     action:@selector(closeButton:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    
    _loaudioButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _loaudioButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _loaudioButton.backgroundColor = [UIColor blueColor];
    _loaudioButton.layer.cornerRadius = 5;
    _loaudioButton.clipsToBounds = YES;
    _loaudioButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_loaudioButton setTitle:@"本地静音"
                    forState:UIControlStateNormal];
    [_loaudioButton setTitle:@"打开声音"
                    forState:UIControlStateSelected];
    _loaudioButton.titleLabel.font = controlFont;
    [_loaudioButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [_loaudioButton setTitleColor:[UIColor lightGrayColor]
                         forState:UIControlStateSelected];
    [_loaudioButton sizeToFit];
    [_loaudioButton addTarget:self
                       action:@selector(_loaudioButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loaudioButton];
    
    
    _reaudioButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _reaudioButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _reaudioButton.backgroundColor = [UIColor blueColor];
    _reaudioButton.layer.cornerRadius = 5;
    _reaudioButton.clipsToBounds = YES;
    _reaudioButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_reaudioButton setTitle:@"远程静音"
                    forState:UIControlStateNormal];
    [_reaudioButton setTitle:@"打开声音"
                    forState:UIControlStateSelected];
    _reaudioButton.titleLabel.font = controlFont;
    [_reaudioButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [_reaudioButton setTitleColor:[UIColor lightGrayColor]
                         forState:UIControlStateSelected];
    [_reaudioButton sizeToFit];
    [_reaudioButton addTarget:self
                       action:@selector(_reaudioButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reaudioButton];
    
    
    
    _jiepinButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _jiepinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _jiepinButton.backgroundColor = [UIColor blueColor];
    _jiepinButton.layer.cornerRadius = 5;
    _jiepinButton.clipsToBounds = YES;
    _jiepinButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_jiepinButton setTitle:@"截屏"
                   forState:UIControlStateNormal];
    _jiepinButton.titleLabel.font = controlFont;
    [_jiepinButton setTitleColor:[UIColor whiteColor]
                        forState:UIControlStateNormal];
    [_jiepinButton setTitleColor:[UIColor lightGrayColor]
                        forState:UIControlStateSelected];
    [_jiepinButton sizeToFit];
    [_jiepinButton addTarget:self
                      action:@selector(_jiepinButton:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_jiepinButton];
    
    
    _luxiangButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _luxiangButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _luxiangButton.backgroundColor = [UIColor blueColor];
    _luxiangButton.layer.cornerRadius = 5;
    _luxiangButton.clipsToBounds = YES;
    _luxiangButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_luxiangButton setTitle:@"录像"
                    forState:UIControlStateNormal];
    _luxiangButton.titleLabel.font = controlFont;
    [_luxiangButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [_luxiangButton setTitleColor:[UIColor lightGrayColor]
                         forState:UIControlStateSelected];
    [_luxiangButton sizeToFit];
    [_luxiangButton addTarget:self
                       action:@selector(_luxiangButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_luxiangButton];
    
    
    
    _luxiangButtonstop = [[UIButton alloc] initWithFrame:CGRectZero];
    _luxiangButtonstop = [UIButton buttonWithType:UIButtonTypeSystem];
    _luxiangButtonstop.backgroundColor = [UIColor blueColor];
    _luxiangButtonstop.layer.cornerRadius = 5;
    _luxiangButtonstop.clipsToBounds = YES;
    _luxiangButtonstop.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_luxiangButtonstop setTitle:@"停止录像"
                        forState:UIControlStateNormal];
    _luxiangButtonstop.titleLabel.font = controlFont;
    [_luxiangButtonstop setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
    [_luxiangButtonstop setTitleColor:[UIColor lightGrayColor]
                             forState:UIControlStateSelected];
    [_luxiangButtonstop sizeToFit];
    [_luxiangButtonstop addTarget:self
                           action:@selector(_luxiangButtonstop:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_luxiangButtonstop];
    
    
<<<<<<< HEAD
    lashentiancButtonstop = [[UIButton alloc] initWithFrame:CGRectZero];
    lashentiancButtonstop = [UIButton buttonWithType:UIButtonTypeSystem];
    lashentiancButtonstop.backgroundColor = [UIColor blueColor];
    lashentiancButtonstop.layer.cornerRadius = 5;
    lashentiancButtonstop.clipsToBounds = YES;
    lashentiancButtonstop.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [lashentiancButtonstop setTitle:@"拉伸填充"
                           forState:UIControlStateNormal];
    lashentiancButtonstop.titleLabel.font = controlFont;
    [lashentiancButtonstop setTitleColor:[UIColor whiteColor]
                                forState:UIControlStateNormal];
    [lashentiancButtonstop setTitleColor:[UIColor lightGrayColor]
                                forState:UIControlStateSelected];
    [lashentiancButtonstop sizeToFit];
    [lashentiancButtonstop addTarget:self
                              action:@selector(lashentiancButtonstop:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lashentiancButtonstop];
    
    
    shiyingdaxiaoButtonstop = [[UIButton alloc] initWithFrame:CGRectZero];
    shiyingdaxiaoButtonstop = [UIButton buttonWithType:UIButtonTypeSystem];
    shiyingdaxiaoButtonstop.backgroundColor = [UIColor blueColor];
    shiyingdaxiaoButtonstop.layer.cornerRadius = 5;
    shiyingdaxiaoButtonstop.clipsToBounds = YES;
    shiyingdaxiaoButtonstop.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [shiyingdaxiaoButtonstop setTitle:@"自适应"
                             forState:UIControlStateNormal];
    shiyingdaxiaoButtonstop.titleLabel.font = controlFont;
    [shiyingdaxiaoButtonstop setTitleColor:[UIColor whiteColor]
                                  forState:UIControlStateNormal];
    [shiyingdaxiaoButtonstop setTitleColor:[UIColor lightGrayColor]
                                  forState:UIControlStateSelected];
    [shiyingdaxiaoButtonstop sizeToFit];
    [shiyingdaxiaoButtonstop addTarget:self
                                action:@selector(shiyingdaxiaoButtonstop:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shiyingdaxiaoButtonstop];
    
    
    
    suofangtianmanButtonstop = [[UIButton alloc] initWithFrame:CGRectZero];
    suofangtianmanButtonstop = [UIButton buttonWithType:UIButtonTypeSystem];
    suofangtianmanButtonstop.backgroundColor = [UIColor blueColor];
    suofangtianmanButtonstop.layer.cornerRadius = 5;
    suofangtianmanButtonstop.clipsToBounds = YES;
    suofangtianmanButtonstop.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [suofangtianmanButtonstop setTitle:@"适应填充"
                              forState:UIControlStateNormal];
    suofangtianmanButtonstop.titleLabel.font = controlFont;
    [suofangtianmanButtonstop setTitleColor:[UIColor whiteColor]
                                   forState:UIControlStateNormal];
    [suofangtianmanButtonstop setTitleColor:[UIColor lightGrayColor]
                                   forState:UIControlStateSelected];
    [suofangtianmanButtonstop sizeToFit];
    [suofangtianmanButtonstop addTarget:self
                                 action:@selector(suofangtianmanButtonstop:)
                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:suofangtianmanButtonstop];
    
    
    
    
    logLable = [[UITextView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, self.view.frame.size.width, 300)];
    logLable.editable = NO;
    [self.view addSubview:logLable];
    
    CGRect connectFrame = CGRectMake(0, 0, 90, 36);
=======
    
    
    logLable = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300)];
    logLable.userInteractionEnabled = NO;
    [self.view addSubview:logLable];
    
    CGRect connectFrame = CGRectMake(0, 10, 90, 40);
>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
    connectFrame.origin.y =
    CGRectGetMaxY(connectFrame) - 10;
    _bindButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _callButton.frame = connectFrame;
<<<<<<< HEAD
    
=======

>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _stopButton.frame = connectFrame;
    
<<<<<<< HEAD
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _closeButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
=======
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _closeButton.frame = connectFrame;

    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
    _luxiangButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _luxiangButtonstop.frame = connectFrame;
    
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _jiepinButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _loaudioButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 5;
    _reaudioButton.frame = connectFrame;
    
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    connectFrame.origin.x = CGRectGetMaxX(connectFrame) + 10;
    shiyingdaxiaoButtonstop.frame = connectFrame;
    
    
    connectFrame.origin.x = CGRectGetMaxX(connectFrame) + 10;
    lashentiancButtonstop.frame = connectFrame;
    
    
    connectFrame.origin.x = CGRectGetMaxX(connectFrame) + 10;
    suofangtianmanButtonstop.frame = connectFrame;
    
    
    /** 设置声音配置 */
    [self loadSpekerConfig];
    
    [self login];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define  Pudding 1
//#define  User_Phone @"18500682208"
#define  User_Phone @"15811231071"
#define  User_Psd @"123456"
//#define  User_Pudding @"1011000000000002"
//#define  User_Pudding @"1011000000200C15"
#define  User_Pudding @"1011000000200C0D"
//#define  User_Pudding @"1011000000200BAE"

//#define  User_Pudding @"1011000000000026"
//#define User_Pudding @"B93BFACD9BD9B7FD"

- (void)login {
    NSURL *URL=[NSURL URLWithString:@"https://pds-api.roo.bo/users/login"];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=15.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    NSDictionary * resultDict = @{@"action":@"login",@"data":@{@"phonenum":User_Phone,@"pushid":@"pushid1231231312313",@"tm":[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]],@"passwd":[self md5HexDigest:User_Psd],@"wifimac":@"fdasfsdafdsafsd"}};
    
    NSData *jsonData =  [NSJSONSerialization dataWithJSONObject:resultDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[json dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    if(data == nil)
        return;
    
    id test  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if(test && [[test objectForKey:@"res"] intValue] == 0){
        
        NSString * usertoken = test[@"data"][@"token"];
        NSString * useruserid = test[@"data"][@"userid"];
        
        _token = [usertoken copy];
        _user = [useruserid copy];
        
        NSLog(@"%@",test);
        NSLog(@"%@",result);
        NSLog(@"%@",usertoken);
        NSLog(@"%@",useruserid);
    }
    
    [self sdk];
    
}
#pragma mark 监听声道的改变
- (void)routeChange:(NSNotification*)notify{
    if(notify){
        [self log:[NSString stringWithFormat:@"声音声道改变%@",notify]];
    }
    
    AVAudioSessionRouteDescription*route = [[AVAudioSession sharedInstance]currentRoute];
    for (AVAudioSessionPortDescription * desc in [route outputs]) {
        
        [self log:[NSString stringWithFormat:@"输出源名称%@",[desc portName]]];
        [self log:[NSString stringWithFormat:@"当前声道%@",[desc portType]]];
        
        if ([[desc portType] isEqualToString:@"Headphones"] || [[desc portType] isEqualToString:@"BluetoothHFP"] || [[desc portType] isEqualToString:@"BluetoothA2DPOutput"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
            });
        }else{
            [self log:@"设置为扬声器"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
            });
        }
        
        
    }
}

/**
 *  @author 智奎宇, 16-01-14 16:01:35
 *
 *  设置声音播放配置
 */
- (void)loadSpekerConfig{
    /** 6.设置后台播放声音 */
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: nil];
    
    
    [self routeChange:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
/* sdk */
- (void)sdk {
    mClient = [RBVideoClient getClient:_user Token:_token Psd:@"aa" APIKEY:@"apikey" APPID:@"1234" ServerURL:@"wss://v3.roo.bo/ws"];
    mClient.delegate = self;
<<<<<<< HEAD
    
=======

>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
    [mClient begin];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView * view = [mClient getVideoView];
        [mClient setViewModle:RBViewAspectFill];
        view.frame = CGRectMake(100, 30, 300, 300);
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
    });
    
}


- (void)shiyingdaxiaoButtonstop:(id)sender{
    [mClient setViewModle:RBViewScaleAspectFit];
}

- (void)suofangtianmanButtonstop:(id)sender{
    [mClient setViewModle:RBViewAspectFill];
}

- (void)lashentiancButtonstop:(id)sender{
    [mClient setViewModle:RBViewScaleToFill];
}

- (void)_luxiangButtonstop:(id)sender{
    [mClient stopRecoredVideo];
}

- (void)_jiepinButton:(UITapGestureRecognizer *)recognizer {
    [mClient screenCapture];
    
}

- (void)_luxiangButton:(UITapGestureRecognizer *)recognizer {
    [mClient startRecoredVideo];
    
}

- (void)stopButton:(UITapGestureRecognizer *)recognizer {
    [mClient hangup];
}

- (void)closeButton:(UITapGestureRecognizer *)recognizer {
    [mClient free];
    
}

- (void)_loaudioButton:(UIButton *)sender{
    sender.selected = !sender.selected;
    [mClient setLocalAudioEnable:sender.selected];
    
}

- (void)_reaudioButton:(UIButton *)sender{
    sender.selected = !sender.selected;
    [mClient setRemoteAudioEnable:sender.selected];
}


- (void)bindButton:(UITapGestureRecognizer *)recognizer {
    [self sdk];
}

- (void)callButton:(UITapGestureRecognizer *)recognizer {
    [mClient call:User_Pudding];
}


- (NSString *)md5HexDigest:(NSString *)pwd1
{
    NSString * input = [NSString stringWithFormat:@"geG^_s[3Kl%@",pwd1];
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
- (void)saveRecoredVideo{
<<<<<<< HEAD
    
    BOOL isEsit = [[NSFileManager defaultManager] fileExistsAtPath:mClient.recordVideoOutputPath];
    if(!isEsit){
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(00, 0), ^{
            ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
            [assetLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:mClient.recordVideoOutputPath] completionBlock:^(NSURL *assetURL, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(error){
                        [self log:@"保存失败"];
                    }else{
                        [self log:@"录像已经保存相册"];
                    }
                });
            }];
        });
    });
}

- (void)log:(NSString *)logtext{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",logtext);
        NSString * str = logLable.text;
        if(str == nil){
            str = @"";
        }
        [logLable scrollsToTop];
        logLable.text = [[NSString stringWithFormat:@"%@\n",logtext] stringByAppendingString:logLable.text];
        [logLable setContentOffset:CGPointMake(0,0) animated:YES];
    });
    
=======
>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
    
    BOOL isEsit = [[NSFileManager defaultManager] fileExistsAtPath:mClient.recordVideoOutputPath];
    if(!isEsit){
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(00, 0), ^{
            ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
            [assetLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:mClient.recordVideoOutputPath] completionBlock:^(NSURL *assetURL, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(error){
                        [self log:@"保存失败"];
                    }else{
                        [self log:@"录像已经保存相册"];
                    }
                });
            }];
        });
    });
}

- (void)log:(NSString *)logtext{
    NSLog(@"%@",logtext);
    NSString * str = logLable.text;
    if(str == nil){
        str = @"";
    }
    logLable.text = [str stringByAppendingString:[NSString stringWithFormat:@"\n%@",logtext]];
    [logLable setContentOffset:CGPointMake(0, MAX(logLable.contentSize.height - logLable.frame.size.height, 0)) animated:YES];
}



#pragma mark - RBVideoEventDelegate

/**
 *  @author 智奎宇, 16-06-02 12:06:05
 *
 *  视频截图
 *
 *  @param state 截图状态
 *  @param msg   信息
 */
- (void)captureVideo:(CAPTURE_VIDEO_STATE) state ResultImage:(UIImage *)captureImage Msg:(NSString *)msgInfo{
    switch (state) {
        case CAPTURE_VIDEO_SCUESS:
        {
            [self log:@"截屏成功"];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"截屏" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(180, 5, 85, 75)];
            UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0,0,400, 35)];
            UITextField *tf2 = [[UITextField alloc]initWithFrame:CGRectMake(0,37,400, 35)];
            tf.backgroundColor = [UIColor whiteColor];
            tf2.backgroundColor = [UIColor whiteColor];
            [view addSubview:tf];
            [view addSubview:tf2];
            
            [alertView setValue:view forKey:@"accessoryView"];
            
            [alertView show];
            
            break;
        }
        case CAPTURE_VIDEO_ERROR:{
            [self log:@"截屏失败"];
            break;
        }
        default:
            break;
    }



}
<<<<<<< HEAD



#pragma mark - RBVideoEventDelegate

/**
 *  @author 智奎宇, 16-06-02 12:06:05
 *
 *  视频截图
 *
 *  @param state 截图状态
 *  @param msg   信息
 */
- (void)captureVideo:(CAPTURE_VIDEO_STATE) state ResultImage:(UIImage *)captureImage Msg:(NSString *)msgInfo{
    switch (state) {
        case CAPTURE_VIDEO_SCUESS:
        {
            [self log:@"截屏成功"];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"截屏" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(180, 5, 85, 85)];
            UIImageView * imagev = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 85, 85)];
            imagev.image= captureImage;
            [view addSubview:imagev];
            
            
            [alertView setValue:view forKey:@"accessoryView"];
            
            [alertView show];
            
            break;
        }
        case CAPTURE_VIDEO_ERROR:{
            [self log:@"截屏失败"];
            break;
        }
        default:
            break;
    }
    
    
    
}
/**
 *  @author 智奎宇, 16-06-02 12:06:50
 *
 *  视频录制
 *
 *  @param state 视频录制状态
 *  @param msg   信息
 */
- (void)recoredVideo:(RECORDER_VIDEO_STATE) state Msg:(id)msg{
    switch (state) {
        case RECORDER_VIDEO_STARTED:
            [self log:@"开始录制视频"];
            break;
        case RECORDER_VIDEO_STOPED:
            [self log:@"停止录制视频"];
            [self saveRecoredVideo];
            break;
        case RECORDER_VIDEO_ERROR:
            [self log:@"视频录制出错"];
            break;
        default:
            break;
    }
    
}
/**
 *  @author 智奎宇, 16-06-02 12:06:55
 *
 *  登陆视频服务器错误
 *
 *  @param errorEvent 错误事件
 *  @param msg        错误信息
 */
- (void)videoConnectServerError:(CONNECT_SERVER_ERROR)errorEvent Msg:(id)msg{
    switch (errorEvent) {
        case  SERVER_RECONNECT:
            [self log:@"视频服务器用户信息错误，正在重连"];
            break;
        case SERVER_USERINFO_INVALID:
            [self log:@"视频服务器用户信息错误，登陆信息错误"];
            break;
        case SERVER_ADDRESS_INVALID:
            [self log:@"视频服务器地址错误"];
            break;
        case SERVER_CLOSE:
            [self log:@"视频服务器断开"];
            break;
        case SERVER_ERROR:
            [self log:@"视频服务器断开_错误"];
            break;
        case SERVER_LOGIN_ERROR:
            [self log:@"视频服务器登陆失败"];
            break;
        case SERVER_LOGINOUT:
            [self log:@"视频服务器退出登陆"];
            break;
        default:
            break;
    }
    
}

/**
 *  @author 智奎宇, 16-06-02 12:06:39
 *
 *  视频服务器登陆状态
 */
- (void)videoConnectServer:(CONNECT_SERVER_STATE)state{
    switch (state) {
        case CONNECT_SERVER_OPENED:
            [self log:@"视频服务器打开"];
            break;
        case CONNECT_SERVER_LOGIN:
            [self log:@"视频服务器登录成功"];
            break;
        default:
            break;
    }
}
/**
 *  @author 智奎宇, 16-06-02 12:06:50
 *
 *  观看视频失败
 *
 *  @param errorEvent 错误类型
 *  @param msg        错误信息
 */
- (void)videoConnectVideoError:(CONNECT_VIDEO_ERROR)errorEvent Msg:(id)msg{
    
    switch (errorEvent) {
        case CONNECT_VIDEO_STATE_ERROR:
            [self log:@"视频服务器状态错误"];
            break;
        case CONNECT_VIDEO_FAIL:
            [self log:@"视频连接失败"];
            break;
        case CONNECT_VIDEO_SERVER_ERROR:
            [self log:@"视频服务错误"];
            break;
        case CONNECT_VIDEO_HANGUP:
            [self log:@"视频断开"];
            break;
        case CONNECT_VIDEO_BUDY:
            [self log:@"对方正忙"];
            break;
        case CONNECT_VIDEO_OFFLINE:
            [self log:@"布丁端不在线"];
            break;
        case CONNECT_VIDEO_PERMISSION:
            [self log:@"没有绑定布丁"];
            break;
        case CONNECT_VIDEO_HALLON:
            [self log:@"霍尔开关打开"];
            break;
        default:
            break;
    }
    
}

/**
 *  @author 智奎宇, 16-06-02 12:06:17
 *
 *  视频连接状态
 *
 *  @param state    状态
 *  @param progress 连接进度，参考进度，由4个状态评估
 */
- (void)videoConnectVideoState:(CONNECT_VIDEO_STATE)state DefaultProgress:(int)progress{
    switch (state) {
        case CONNECT_VIDEO_ACCEPT:
            [self log:@"同意呼叫"];
            break;
        case CONNECT_VIDEO_ANSWER:
            [self log:@"收到视频连接回复"];
            break;
        case CONNECT_VIDEO_INFO:
            [self log:@"收到视频连接信息"];
            break;
        case CONNECT_VIDEO_BYE:
            [self log:@"收到视频断开消息"];
            break;
        case CONNECT_VIDEO_SCUESS:
            [self log:@"视频连接成功"];
=======
/**
 *  @author 智奎宇, 16-06-02 12:06:50
 *
 *  视频录制
 *
 *  @param state 视频录制状态
 *  @param msg   信息
 */
- (void)recoredVideo:(RECORDER_VIDEO_STATE) state Msg:(id)msg{
    switch (state) {
        case RECORDER_VIDEO_STARTED:
            [self log:@"开始录制视频"];
            break;
        case RECORDER_VIDEO_STOPED:
            [self log:@"停止录制视频"];
            [self saveRecoredVideo];
            break;
        case RECORDER_VIDEO_ERROR:
            [self log:@"视频录制出错"];
            break;
        default:
            break;
    }

}
/**
 *  @author 智奎宇, 16-06-02 12:06:55
 *
 *  登陆视频服务器错误
 *
 *  @param errorEvent 错误事件
 *  @param msg        错误信息
 */
- (void)videoConnectServerError:(CONNECT_SERVER_ERROR)errorEvent Msg:(id)msg{
    switch (errorEvent) {
        case SERVER_USERINFO_INVALID:
            [self log:@"视频服务器用户信息错误，登陆信息错误"];
            break;
        case SERVER_ADDRESS_INVALID:
            [self log:@"视频服务器地址错误"];
            break;
        case SERVER_CLOSE:
            [self log:@"视频服务器断开"];
            break;
        case SERVER_ERROR:
            [self log:@"视频服务器断开_错误"];
            break;
        case SERVER_LOGIN_ERROR:
            [self log:@"视频服务器登陆失败"];
            break;
        case SERVER_LOGINOUT:
            [self log:@"视频服务器退出登陆"];
            break;
        default:
            break;
    }
    
}

/**
 *  @author 智奎宇, 16-06-02 12:06:39
 *
 *  视频服务器登陆状态
 */
- (void)videoConnectServer:(CONNECT_SERVER_STATE)state{
    switch (state) {
        case CONNECT_SERVER_OPENED:
            [self log:@"视频服务器打开"];
            break;
        case CONNECT_SERVER_LOGIN:
            [self log:@"视频服务器登录成功"];
            break;
        default:
            break;
    }
}
/**
 *  @author 智奎宇, 16-06-02 12:06:50
 *
 *  观看视频失败
 *
 *  @param errorEvent 错误类型
 *  @param msg        错误信息
 */
- (void)videoConnectVideoError:(CONNECT_VIDEO_ERROR)errorEvent Msg:(id)msg{

    switch (errorEvent) {
        case CONNECT_VIDEO_STATE_ERROR:
            [self log:@"视频服务器状态错误"];
            break;
        case CONNECT_VIDEO_FAIL:
            [self log:@"视频连接失败"];
            break;
        case CONNECT_VIDEO_SERVER_ERROR:
            [self log:@"视频服务错误"];
            break;
        case CONNECT_VIDEO_HANGUP:
            [self log:@"视频断开"];
            break;
        case CONNECT_VIDEO_BUDY:
            [self log:@"对方正忙"];
            break;
        case CONNECT_VIDEO_OFFLINE:
            [self log:@"布丁端不在线"];
            break;
        case CONNECT_VIDEO_PERMISSION:
            [self log:@"没有绑定布丁"];
            break;
        case CONNECT_VIDEO_HALLON:
            [self log:@"霍尔开关打开"];
>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b
            break;
        default:
            break;
    }
    
}

<<<<<<< HEAD
=======
/**
 *  @author 智奎宇, 16-06-02 12:06:17
 *
 *  视频连接状态
 *
 *  @param state    状态
 *  @param progress 连接进度，参考进度，由4个状态评估
 */
- (void)videoConnectVideoState:(CONNECT_VIDEO_STATE)state DefaultProgress:(int)progress{
    switch (state) {
        case CONNECT_VIDEO_CALL_OK:
            [self log:@"发送呼叫命令相应成功"];
            break;
        case CONNECT_VIDEO_ACCEPT:
            [self log:@"同意呼叫"];
            break;
        case CONNECT_VIDEO_ANSWER:
            [self log:@"收到视频连接回复"];
            break;
        case CONNECT_VIDEO_INFO:
            [self log:@"收到视频连接信息"];
            break;
        case CONNECT_VIDEO_BYE:
            [self log:@"收到视频断开消息"];
            break;
        case CONNECT_VIDEO_SCUESS:
            [self log:@"视频连接成功"];
            break;
        default:
            break;
    }
    
}



>>>>>>> 18f6980cee5764e763d379f6f98ca80a35aed18b



@end
