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
#import "GAOpenLiveModel.h"

#import <AlivcLivePusher/AlivcLivePusher.h>
#import <AlivcLibFace/AlivcLibFaceManager.h>
#import <AlivcLibBeauty/AlivcLibBeautyManager.h>

//相机设置相关  （美颜调整等）
@interface GAOpenLiveViewController (CameraSetter)
<
AlivcLivePusherCustomFilterDelegate,
AlivcLivePusherCustomDetectorDelegate,
AlivcLivePusherInfoDelegate
>

@end

@interface GAOpenLiveViewController ()<GAOpenLiveControllerDelegate,GALiveBroadcastControlViewDelegate>

@property(nonatomic,strong)GAOpenLiveControlView *controlView;  //!<UI
@property(nonatomic,strong)AlivcLivePusher *pusher;             //!<相机与推流
@property(nonatomic,strong)GALiveBroadcastControlView *liveBroadcast;

@property(nonatomic,strong)GABeautyFilterParams *params;

@property(nonatomic,strong)GAOpenLiveModel *liveModel;

@property(nonatomic,strong)MBProgressHUD *openLiveHUD;  //开播请求数据 状态反馈

@property(nonatomic,assign)int totalTime;       //!<秒
@property(nonatomic,strong)UILabel *timeLabel;  //!<计时显示
@property(nonatomic,strong)NSTimer *timer;      //!<直播计时器


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
    
    
    _totalTime = 0;
    _params = [GABeautyFilterParams defaultBeautyParamsWithLevel:GABeautyParamsLevel4];
    
  
    GALivePushConfig *cfg = [[GALivePushConfig alloc] init];
    [cfg setParams:_params];
   // [AlivcLivePusher showDebugView];
    self.pusher = [[AlivcLivePusher alloc] initWithConfig:cfg];
    
    [self.pusher setCustomFilterDelegate:self];
    [self.pusher setCustomDetectorDelegate:self];
    [self.pusher setInfoDelegate:self];
 
    
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
    
    self.timeLabel = UILabel.new;
    [self.timeLabel  setFont:MainFontWithSize(22)];
    [self.timeLabel setTextColor:UIColor.whiteColor];
    
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.controlView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.pusher startPreview:self.view];
    
    //移到上层
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.controlView];

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.controlView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.view).insets(UIEdgeInsetsMake(self.view.safeAreaInsets.top+8, 0, 0, 16));
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

- (NSTimer *)timer{
    if (!_timer) {
        __weak typeof(self) wself = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            wself.totalTime += 1;
            
            NSString *min = [NSString stringWithFormat:@"%.02d",wself.totalTime/60];
            NSString *sec = [NSString stringWithFormat:@"%.02d",wself.totalTime%60];
            NSString *text = [NSString stringWithFormat:@"%@:%@",min,sec];
            [wself.timeLabel setText:text];
        }];
    }
    return _timer;
}


#pragma mark - GAOpenLiveControllerDelegate
- (void)startLiveWiteTitle:(NSString *)title image:(UIImage *)cover location:(GALocationInfo)info selectedGoods:(nonnull NSArray<GALiveGoodsModel *> *)goodsList{
    
    if (title.length <= 0) {
        [self showHUDToView:self.view message:@"请输入标题"];
        return;
    }
    if (!cover) {
        [self showHUDToView:self.view message:@"请添加张封面吧"];
        return;
    }
    if (!self.controlView.selectedType) {
        [self showHUDToView:self.view message:@"请选择直播类型"];
        return;
    }
    
    // 请求开播 数据
    NSMutableArray *idArray = @[].mutableCopy;
    for (GALiveGoodsModel *goods in goodsList) {
        [idArray addObject:goods.goods_id];
    }
    if (idArray.count <= 0) {
        idArray = nil;
    }
    
    //直播
    void(^beginLive)(NSString* rtmpURL) = ^(NSString* url){
        //NSLog(@"url -- %@",url);
        
        [self.liveBroadcast setPusher:self.pusher];
        [self.liveBroadcast setParams:self.params];
        
        [UIView animateWithDuration:0.35 animations:^{
            [self.controlView setAlpha:0];
        } completion:^(BOOL finished) {
            
            [self.view addSubview:self.liveBroadcast];
            [self.liveBroadcast setLiveMode:self.liveModel];
            [self.liveBroadcast mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
            }];
            [self.view layoutIfNeeded];
        }];
        [self.pusher startPushWithURL:url];
        [self.tabBarController.tabBar setHidden:YES];
    };
    
    
    [self.openLiveHUD removeFromSuperview];
    self.openLiveHUD = [MBProgressHUD showHUDAddedTo:self.controlView animated:YES];
    [self.openLiveHUD.label setText:@"正在连接网络..."];
    [self.controlView.startLiveBtn setEnabled:NO];
    
        //请求地址数据
    int type = [self.controlView.selectedType.identifier intValue];
    
    [GAAPI.new.videoAPI openLiveWithKey:self.loginKey title:title type:type coverImage:cover tag:nil goodsList:idArray lng:info.lng lat:info.lat address:info.address completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        if ([json valueForKey:@"datas"]) {
            //NSLog(@"json --- %@",json);
            
            self.liveModel = [GAOpenLiveModel instanceWithDict:[json valueForKey:@"datas"]];
            [self.openLiveHUD removeFromSuperview];
            beginLive(self.liveModel.push_url);
        }else{
            [self.openLiveHUD.label setText:@"连接服务器出错！"];
            [self.openLiveHUD hideAnimated:YES afterDelay:2.0];
            [self.controlView.startLiveBtn setEnabled:YES];
        }
    }];

    
}
- (void)switchCamera{
    [self.pusher switchCamera];
}

#pragma mark  - GALiveBroadcastControlViewDelegate      (直播进行中的 UIAction)
- (void)stopLive{
    [self.liveBroadcast removeFromSuperview];
    [UIView animateWithDuration:0.35 animations:^{
        [self.controlView setAlpha:1];
        [self.controlView.startLiveBtn setEnabled:YES];
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



#pragma mark - AlivcLivePusherInfoDelegate
/**
 推流开始回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushStarted:(AlivcLivePusher *)pusher{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer fire];
    });
}


/**
 推流暂停回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushPaused:(AlivcLivePusher *)pusher{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
    });
}


/**
 推流恢复回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushResumed:(AlivcLivePusher *)pusher{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
        [self.timer fire];
    });
}


/**
 重新推流回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushRestart:(AlivcLivePusher *)pusher{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
        [self.timer fire];
    });

}


/**
 推流停止回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushStoped:(AlivcLivePusher *)pusher{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
    });
}

@end
