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
@interface RBViewController ()
{

    UIButton *_startButton;
    UIButton *_stopButton;
    UIButton *_bindButton;
    UIButton *_callButton;
    UIButton *_closeButton;
    UIButton *_jiepinButton;
    UIButton *_luxiangButton;
    UIButton *_luxiangButtonstop;
    
    RBVideoClient * mClient;
    UIView *_videoView;
    NSString *_user;
    NSString *_pass;
    NSString *_token;
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
    
    _startButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _startButton.backgroundColor = [UIColor blueColor];
    _startButton.layer.cornerRadius = 5;
    _startButton.clipsToBounds = YES;
    _startButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10);
    [_startButton setTitle:@"start"
                  forState:UIControlStateNormal];
    _startButton.titleLabel.font = controlFont;
    [_startButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor lightGrayColor]
                       forState:UIControlStateSelected];
    [_startButton sizeToFit];
    [_startButton addTarget:self
                     action:@selector(startButton:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
    
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
    
    CGRect connectFrame = CGRectMake(0, 10, 90, 40);
    connectFrame.origin.y =
    CGRectGetMaxY(connectFrame) - 10;
    _bindButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _callButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _startButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _stopButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _closeButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _closeButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _luxiangButton.frame = connectFrame;
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _luxiangButtonstop.frame = connectFrame;
    
    
    connectFrame.origin.y = CGRectGetMaxY(connectFrame) + 10;
    _jiepinButton.frame = connectFrame;
    
    
    [self login];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define  Pudding 1
//#define  User_Phone @"18500682208"
#define  User_Phone @"18500682208"
#define  User_Psd @"123456"
//#define  User_Pudding @"1011000000000002"
#define  User_Pudding @"1011000000200BAE"
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



/* sdk */
- (void)sdk {
    mClient = [[RBVideoClient alloc] init];
//    mClient.delegate = self;
//    RBVideoConfiguration * config = [[RBVideoConfiguration alloc] init];
//    [mClient setConfigation:config];
//    
//    RBVideoAddress * address = [[RBVideoAddress alloc] init];
//    address.urlString = @"wss://v3.roo.bo/ws";
//    [mClient setConnectAddress:address];
//    
//    RBVideoCredential * videoCredential = [[RBVideoCredential alloc] init];
//    videoCredential.token = _token;
//    videoCredential.userId = _user;
//    videoCredential.password = @"1";
//    videoCredential.videoClientId = User_Pudding;
//    videoCredential.appkey = @"appkey";
//    videoCredential.appid = @"1234";
//    [mClient setVideoCredential:videoCredential];
//    [mClient begin];
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIView * view = [mClient getVideoView];
//        view.frame = CGRectMake(100, 30, 300, 300);
//        //        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    });
    
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



- (void)startButton:(UITapGestureRecognizer *)recognizer {
    [mClient call:User_Pudding];
}

- (void)stopButton:(UITapGestureRecognizer *)recognizer {
    [mClient stop];
}

- (void)closeButton:(UITapGestureRecognizer *)recognizer {
    [mClient free];
    
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

#pragma mark -
- (void)videoConnectProgress:(int)progress{
    NSLog(@"----------------fdsfds  %d",progress);
    
}
- (void)videoConnectOnEvent:(VideoConnectState) event Code:(int)code Msg:(id)msg{
    NSLog(@"----------------- %d",event);
    switch (event) {
        case VIDEO_INFO_SERVER_ADDRESS_INVALID:
            NSLog(@"视频连接服务器错误");
            break;
        case VIDEO_INFO_LOGIN_FAIL:
            NSLog(@"呼叫视频失败，没有登录视频服务器");
            break;
        case VIDEO_INFO_LOGIN_INFO_INVALID:
            NSLog(@"用户登录信息错误");
            break;
        case VIDEO_SERVER_CONNECT:
            NSLog(@"视频服务器连接成功");
            break;
        case VIDEO_SERVER_CLOSE:
            NSLog(@"视频服务器断开");
            break;
        case VIDEO_SERVER_LOGIN_SCURSS:
            NSLog(@"登陆成功");
            break;
        case VIDEO_SERVER_LOGIN_FAIL:
            NSLog(@"登陆失败");
            break;
        case VIDEO_CALL_NO_READLY:
            NSLog(@"视频呼叫状态错误 %@",msg);
            break;
        case VIDEO_CALL_ACCEPT:
            NSLog(@"呼叫视频成功");
            break;
        case VIDEO_CALL_FAIL:
            NSLog(@"呼叫视频失败");
            break;
        case VIDEO_CALL_ANSWER:
            NSLog(@"呼叫视频收到回复");
            break;
        case VIDEO_CALL_INFO:
            NSLog(@"呼叫视频收到布丁端的视频信息");
            break;
        case VIDEO_CONNECT_SCUESS:
            NSLog(@"视频连接成功");
            break;
        case VIDEO_CONNECT_FAIL:
            NSLog(@"视频连接失败");
            break;
        case VIDEO_CAPTURE_RESULT:{
            NSLog(@"截屏成功");
            UIImage * img = msg;
            NSLog(@"截屏成功 %@",img);}
            break;
        case VIDEO_CAPTURE_RESULT_ERROR:
            NSLog(@"截屏失败");
            break;
        case VIDEO_RECORDER_STARTED:
            NSLog(@"开始录制视频");
            break;
        case VIDEO_RECORDER_STOPPED:
            NSLog(@"录制视频完成%@",msg);
            break;
        case VIDEO_RECORDER_UNKOWN:
            NSLog(@"视频录制错误");
            break;
        case VIDEO_RECORDER_ERROR:
            NSLog(@"视频必须打开");
            break;
        default:
            NSLog(@"fds");
            break;
    }
    
}
@end
