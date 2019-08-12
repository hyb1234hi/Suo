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

#import "GABeautyFilterParams.h"
#import "GALivePushConfig.h"
#import "GAAPI.h"

#import <AlivcLivePusher/AlivcLivePusher.h>
#import <AlivcLibFace/AlivcLibFaceManager.h>
#import <AlivcLibBeauty/AlivcLibBeautyManager.h>

//相机设置相关  （美颜调整等）
@interface GAOpenLiveViewController (CameraSetter)
<
AlivcLivePusherCustomFilterDelegate,
AlivcLivePusherCustomDetectorDelegate
>

@end

@interface GAOpenLiveViewController ()<GAOpenLiveControllerDelegate,GALiveBroadcastControlViewDelegate>

@property(nonatomic,strong)GAOpenLiveControlView *controlView;  //!<UI
@property(nonatomic,strong)AlivcLivePusher *pusher;             //!<相机与推流
@property(nonatomic,strong)GALiveBroadcastControlView *liveBroadcast;

@property(nonatomic,strong)GABeautyFilterParams *params;

//@property(nonatomic,strong)<#class#> *<#name#>;

@end

@implementation GAOpenLiveViewController

- (void)dealloc{

    [self disPusher];
}
- (void)disPusher{
    [_pusher stopPush];
    [_pusher stopPreview];
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

    _params = [GABeautyFilterParams defaultBeautyParamsWithLevel:GABeautyParamsLevel4];
    
    //初始化推流、相机
    ({
        GALivePushConfig *cfg = [[GALivePushConfig alloc] init];
        [cfg setParams:_params];
        
       // [AlivcLivePusher showDebugView];
        self.pusher = [[AlivcLivePusher alloc] initWithConfig:cfg];
        
        [self.pusher setCustomFilterDelegate:self];
        [self.pusher setCustomDetectorDelegate:self];
    });
    
    [self setupUI];
    [self.controlView setParams:self.params];
    [self.controlView setPusher:self.pusher];
    
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.pusher startPreview:self.view];
    [self.view insertSubview:self.controlView atIndex:1]; //移到上层

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.controlView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
    }];
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
- (void)startLiveWiteTitle:(NSString *)title image:(UIImage *)cover location:(CLLocationCoordinate2D)location selectedGoods:(NSArray<GALiveGoodsModel *> *)goodsList{
    
    if (title.length <= 0) {
        [self showHUDToView:self.view message:@"请输入标题"];
        return;
    }
    if (!cover) {
        [self showHUDToView:self.view message:@"请添加张封面吧"];
        return;
    }
    
    // 请求开播 数据
    NSMutableArray *idArray = @[].mutableCopy;
    
    [GAAPI.new.videoAPI openLiveWithKey:self.loginKey title:title type:0 coverImage:cover tag:nil goodsList:idArray lng:location.longitude lat:location.latitude completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSLog(@"json ------ %@",json);
    }];
    
    
    
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
    [self.tabBarController.tabBar setHidden:YES];
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
    
    [self.tabBarController.tabBar setHidden:NO];
}

@end


#pragma mark - cammera setter

@implementation GAOpenLiveViewController (CameraSetter)
/**
 通知外置滤镜创建回调
 */
- (void)onCreate:(AlivcLivePusher *)pusher context:(void*)context
{
    [[AlivcLibBeautyManager shareManager] create:context];
}

- (void)updateParam:(AlivcLivePusher *)pusher buffing:(float)buffing whiten:(float)whiten pink:(float)pink cheekpink:(float)cheekpink thinface:(float)thinface shortenface:(float)shortenface bigeye:(float)bigeye
{
    [[AlivcLibBeautyManager shareManager] setParam:buffing whiten:whiten pink:pink cheekpink:cheekpink thinface:thinface shortenface:shortenface bigeye:bigeye];
    
}

- (void)switchOn:(AlivcLivePusher *)pusher on:(bool)on
{
    [[AlivcLibBeautyManager shareManager] switchOn:on];
}
/**
 通知外置滤镜处理回调
 */
- (int)onProcess:(AlivcLivePusher *)pusher texture:(int)texture textureWidth:(int)width textureHeight:(int)height extra:(long)extra
{
    return [[AlivcLibBeautyManager shareManager] process:texture width:width height:height extra:extra];
}
/**
 通知外置滤镜销毁回调
 */
- (void)onDestory:(AlivcLivePusher *)pusher
{
    [[AlivcLibBeautyManager shareManager] destroy];
}




#pragma mark - AlivcLivePusherCustomDetectorDelegate
/**
 通知外置视频检测创建回调
 */
- (void)onCreateDetector:(AlivcLivePusher *)pusher
{
    [[AlivcLibFaceManager shareManager] create];
}
/**
 通知外置视频检测处理回调
 */
- (long)onDetectorProcess:(AlivcLivePusher *)pusher data:(long)data w:(int)w h:(int)h rotation:(int)rotation format:(int)format extra:(long)extra
{
    return [[AlivcLibFaceManager shareManager] process:data width:w height:h rotation:rotation format:format extra:extra];
}
/**
 通知外置视频检测销毁回调
 */
- (void)onDestoryDetector:(AlivcLivePusher *)pusher
{
    [[AlivcLibFaceManager shareManager] destroy];
}

@end
