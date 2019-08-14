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
#import "GALiveBroadcastControlView.h"

#import <AVKit/AVKit.h>

#import <AlivcLivePusher/AlivcLivePusher.h>

#import <KSYGPUStreamerKit.h>


@interface GAShootingViewController ()<GAShootControllerViewDelegate,GALiveBroadcastControlViewDelegate>
@property(nonatomic,strong)GAShootingView *shootingView;
@property(nonatomic,strong)GAShootControllerView *controllerView;
@property(nonatomic,strong)GACaptureConfiguration *configuration;

@property(nonatomic,strong)GALiveBroadcastControlView *liveBroadcast; //!<直播中的控制页面 等

@property(nonatomic,strong)NSURL *hostURL;
@property(nonatomic,strong)KSYGPUStreamerKit *kit;
//@property(nonatomic,strong)AlivcLivePusher *pusher;


@property(nonatomic,assign)BOOL liveStarted;
@end

@implementation GAShootingViewController

- (void)dealloc{
//    [_kit.streamerBase stopStream];
//    [_kit stopPreview];
    
//    [_pusher stopPush];
//    [_pusher destory];
//    _pusher = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:UIColor.blackColor];

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
    _controllerView = GAShootControllerView.new;
    [_controllerView setDelegate:self];

    [self setupAlivcLive];

    [self.view addSubview:_controllerView];
}
- (void)setupKSY{
    
//        NSDate* tmpStartData = [NSDate date] ;
        [self.kit startPreview:self.view];
 //       double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
 //       NSLog(@"da --------------- %g ms",deltaTime*1000);
    
        [self.kit.streamerBase setStreamStateChange:^(KSYStreamState newState) {
            switch (newState) {
                case KSYStreamStateIdle:{
                    NSLog(@"空闲状态");
                }break;
    
                case KSYStreamStateConnecting:{
                    NSLog(@"连接中");
                }break;
    
                case KSYStreamStateConnected:{
                    NSLog(@"连接成功");
                }break;
                case KSYStreamStateDisconnecting:{
                    NSLog(@"断开连接");
                }break;
                case KSYStreamStateError:{
                    NSLog(@"错误 ");
                }break;
            }
        }];
}
- (void)setupAlivcLive{
//    AlivcLivePushConfig *cfg = [[AlivcLivePushConfig alloc] init];
//    [AlivcLivePusher showDebugView];
//    _pusher = [[AlivcLivePusher alloc] initWithConfig:cfg];
//    [_pusher startPreview:self.view];

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
    [_kit.streamerBase stopStream];
    [_kit stopPreview];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 切换镜头
 */
- (void)switchLens{
//    [self.kit switchCamera];
//    switch (self.kit.cameraPosition) {
//            case AVCaptureDevicePositionBack:{
//                NSLog(@"切换到前置相机");
//                [self.kit setCameraPosition:AVCaptureDevicePositionFront];
//            }break;
//
//            case AVCaptureDevicePositionFront:{
//                NSLog(@"q切换到后置相机");
//                 [self.kit setCameraPosition:AVCaptureDevicePositionBack];
//                [self.kit startPreview:self.view];
//            }break;
//
//            case AVCaptureDevicePositionUnspecified:{}break;
//
//    }
    
   // NSLog(@">>>>>>>>>>>>");
    
    
   // [self.pusher switchCamera];
    
    
}
- (void)toggleRecord:(GARecordButton *)send{
    switch (send.buttonState) {
            case GARecordButtonStateRecording:{
                NSURL *url = [NSURL URLWithString:RTMPURL_UP];
                [_kit.streamerBase startStream:url];
               // NSLog(@"url -- %@",url);
                
            }break;
            
        default:
            [_kit.streamerBase stopStream];
            NSLog(@"stop >>>");
            break;
    }
}


#pragma mark - getter

- (KSYGPUStreamerKit *)kit{
    if (!_kit) {
        _kit = [[KSYGPUStreamerKit alloc] initWithDefaultCfg];
        [_kit setVideoProcessingCallback:^(CMSampleBufferRef sampleBuffer) {
           // NSLog(@"video数据  %p",sampleBuffer);
        }];
        [_kit setAudioProcessingCallback:^(CMSampleBufferRef sampleBuffer) {
           // NSLog(@"处理音频数据- %p",sampleBuffer);
        }];
    }
    return _kit;
}
- (GALiveBroadcastControlView *)liveBroadcast{
    if (!_liveBroadcast) {
        _liveBroadcast = GALiveBroadcastControlView.new;
        [_liveBroadcast setDelegate:self];
    }
    return _liveBroadcast;
}


#pragma mark - GAShootControllerViewDelegate            (直播开始前，拍摄前 UIAction)
- (void)startLiveDidClick{
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.controllerView setAlpha:0];
    } completion:^(BOOL finished) {
        self.liveStarted = YES;
        //[self.kit startPreview:self.view];
        //NSURL *url = [NSURL URLWithString:RTMPURL_UP];
        //[self.kit.streamerBase startStream:url];
        
        [self.view addSubview:self.liveBroadcast];
        [self.liveBroadcast mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
        }];
        [self.view layoutIfNeeded];
        
       // [self.pusher startPushWithURL:RTMPURL_UP];
    }];
}



#pragma mark  - GALiveBroadcastControlViewDelegate      (直播进行中的 UIAction)
- (void)stopLive{
    if (self.liveStarted) {
        self.liveStarted = NO;
        //[self.kit.streamerBase stopStream];
       // [self.pusher stopPush];
       
        [self.liveBroadcast removeFromSuperview];

        [UIView animateWithDuration:0.35 animations:^{
            [self.controllerView setAlpha:1];
        }];
    }
}
-(void)switchLensDidClick{
    [self switchLens];
}

#pragma mark 美颜

@end
