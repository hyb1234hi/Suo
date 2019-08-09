//
//  GAOpenLiveViewController.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveViewController.h"
#import "GAOpenLiveControlView.h"
#import "GALiveBroadcastControlView.h"

#import <AlivcLivePusher/AlivcLivePusher.h>

//相机设置相关  （美颜调整等）
@interface GAOpenLiveViewController (CameraSetter)

@end

@interface GAOpenLiveViewController ()<GAOpenLiveControllerDelegate,GALiveBroadcastControlViewDelegate>

@property(nonatomic,strong)GAOpenLiveControlView *controlView;  //!<UI
@property(nonatomic,strong)AlivcLivePusher *pusher;             //!<相机与推流
@property(nonatomic,strong)GALiveBroadcastControlView *liveBroadcast;

@end

@implementation GAOpenLiveViewController

- (void)dealloc{
    [_pusher stopPush];
    [_pusher destory];
    _pusher = nil;
    
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBA(80, 185, 249, 1)];

    //初始化推流、相机
    ({
        AlivcLivePushConfig *cfg = [[AlivcLivePushConfig alloc] init];
        [AlivcLivePusher showDebugView];
        self.pusher = [[AlivcLivePusher alloc] initWithConfig:cfg];
        [self.pusher startPreview:self.view];
    });
    
    [self setupUI];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
}

- (void)setupUI{
    self.controlView = GAOpenLiveControlView.new;
    [self.controlView setFrame:self.view.bounds];
    [self.controlView setDelegate:self];
    
    [self.view addSubview:self.controlView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mari - getter
- (GALiveBroadcastControlView *)liveBroadcast{
    if (!_liveBroadcast) {
        _liveBroadcast = GALiveBroadcastControlView.new;
        [_liveBroadcast setDelegate:self];
    }
    return _liveBroadcast;
}

#pragma mark - GAOpenLiveControllerDelegate
- (void)startLive{
    [UIView animateWithDuration:0.35 animations:^{
        [self.controlView setAlpha:0];
    } completion:^(BOOL finished) {
       
        [self.view addSubview:self.liveBroadcast];
        [self.liveBroadcast mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
        }];
        [self.view layoutIfNeeded];
    }];
    [self.pusher startPushWithURL:RTMPURL_UP];
}
- (void)switchCamera{
    [self.pusher switchCamera];
}

#pragma mark  - GALiveBroadcastControlViewDelegate      (直播进行中的 UIAction)
- (void)stopLive{
    [self.liveBroadcast removeFromSuperview];
    [UIView animateWithDuration:0.35 animations:^{
        [self.controlView setAlpha:1];
    }];
}

@end


#pragma mark - cammera setter

@implementation GAOpenLiveViewController (CameraSetter)

@end
