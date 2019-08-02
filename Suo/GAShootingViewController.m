//
//  GAShootingViewController.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAShootingViewController.h"

#import "GAShootingView.h"
#import "GAShootControllerView.h"
#import "GACaptureConfiguration.h"
#import <AVKit/AVKit.h>


#import <KSYGPUStreamerKit.h>


@interface GAShootingViewController ()<GAShootControllerViewDelegate>
@property(nonatomic,strong)GAShootingView *shootingView;
@property(nonatomic,strong)GAShootControllerView *controllerView;

@property(nonatomic,strong)GACaptureConfiguration *configuration;

@property(nonatomic,strong)NSURL *hostURL;
@property(nonatomic,strong)KSYGPUStreamerKit *streamerKit;

@end

@implementation GAShootingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
    _configuration = GACaptureConfiguration.new;
    _shootingView = [[GAShootingView alloc] initWithFrame:ScreenBounds];
    [_shootingView.captureVideoPreviewLayer setSession:_configuration.captureSession];
    
    _controllerView = GAShootControllerView.new;
    [_controllerView setDelegate:self];
    
//    [self.view addSubview:_shootingView];
    [self.view addSubview:_controllerView];
    
    
    _streamerKit = [[KSYGPUStreamerKit alloc] initWithDefaultCfg];
    [_streamerKit startPreview:self.view];
    
    
    __weak typeof(self) wself = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:KSYStreamStateDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"state --- %d",wself.streamerKit.streamerBase.streamState);
        
        /**
         /// 初始化时状态为空闲
         KSYStreamStateIdle = 0,
         /// 连接中
         KSYStreamStateConnecting,
         /// 已连接
         KSYStreamStateConnected,
         /// 断开连接中
         KSYStreamStateDisconnecting,
         /// 推流出错
         KSYStreamStateError,
         */
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    [self.shootingView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
    [self.controllerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 切换镜头
 */
- (void)switchLens{
    [self.streamerKit switchCamera];
    switch (self.streamerKit.cameraPosition) {
            
            
            case AVCaptureDevicePositionBack:{
                NSLog(@"切换到前置相机");
                [self.streamerKit setCameraPosition:AVCaptureDevicePositionFront];
            }break;
            
            case AVCaptureDevicePositionFront:{
                NSLog(@"q切换到后置相机");
                 [self.streamerKit setCameraPosition:AVCaptureDevicePositionBack];
                [self.streamerKit startPreview:self.view];
            }break;
            
            case AVCaptureDevicePositionUnspecified:{}break;

    }
}
- (void)toggleRecord:(GARecordButton *)send{
    switch (send.buttonState) {
            case GARecordButtonStateRecording:{
                NSURL *url = [NSURL URLWithString:RTMPURL_UP];
                [_streamerKit.streamerBase startStream:url];
                NSLog(@"url -- %@",url);
                
            }break;
            
        default:
            [_streamerKit.streamerBase stopStream];
            NSLog(@"stop >>>");
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self.view];
    [_streamerKit focusAtPoint:point];
    [_streamerKit exposureAtPoint:point];
}

@end
