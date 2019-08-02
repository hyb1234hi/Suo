//
//  GA_KSYLive.m
//  Suo
//
//  Created by ysw on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GA_KSYLive.h"

@implementation GA_KSYLive


- (void)defaultStramCfg{
    _kit.streamerBase.videoCodec = KSYVideoCodec_AUTO;
    _kit.streamerBase.videoInitBitrate =  800;
    _kit.streamerBase.videoMaxBitrate  = 1000;
    _kit.streamerBase.videoMinBitrate  =    0;
    _kit.streamerBase.audiokBPS        =   48;
        // 设置编码的场景
    _kit.streamerBase.liveScene       = KSYLiveScene_Default;
        // 设置编码码率控制
    _kit.streamerBase.recScene        = KSYRecScene_ConstantQuality;
        // 视频编码性能档次 (硬编码建议用HighPerformance)
    if(_kit.streamerBase.videoCodec == KSYVideoCodec_AUTO ||
       _kit.streamerBase.videoCodec == KSYVideoCodec_VT264) {
        _kit.streamerBase.videoEncodePerf = KSYVideoEncodePer_HighPerformance;
    }
    else { // 软编码建议用 lowpower
        _kit.streamerBase.videoEncodePerf = KSYVideoEncodePer_LowPower;
    }
    _kit.streamerBase.logBlock = ^(NSString* str){
        NSLog(@"%@", str);
    };
   // _hostURL = [NSURL URLWithString:@"rtmp://120.92.224.235/live/123"];
}

- (KSYGPUStreamerKit *)kit{
    if (!_kit) {
        _kit = [[KSYGPUStreamerKit alloc] initWithDefaultCfg];
        [self defaultStramCfg];
    }
    return _kit;
}
@end
