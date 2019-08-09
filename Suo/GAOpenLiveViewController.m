//
//  GAOpenLiveViewController.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveViewController.h"
#import "GAOpenLiveControlView.h"

#import <AlivcLivePusher/AlivcLivePusher.h>

//相机设置相关  （美颜调整等）
@interface GAOpenLiveViewController (CameraSetter)

@end

@interface GAOpenLiveViewController ()<GAOpenLiveControllerDelegate>

@property(nonatomic,strong)GAOpenLiveControlView *controlView;  //!<UI
@property(nonatomic,strong)AlivcLivePusher *pusher;             //!<相机与推流

@end

@implementation GAOpenLiveViewController

- (void)dealloc{
    [_pusher stopPush];
    [_pusher destory];
    _pusher = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBA(80, 185, 249, 1)];

    //初始化推流、相机
    ({
        AlivcLivePushConfig *cfg = [[AlivcLivePushConfig alloc] init];
        //[AlivcLivePusher showDebugView];
        self.pusher = [[AlivcLivePusher alloc] initWithConfig:cfg];
        [self.pusher startPreview:self.view];
    });
    
    [self setupUI];
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

#pragma mark - GAOpenLiveControllerDelegate
- (void)startLive{
    
}
- (void)switchCamera{
    [self.pusher switchCamera];
}

@end


#pragma mark - cammera setter

@implementation GAOpenLiveViewController (CameraSetter)



@end
