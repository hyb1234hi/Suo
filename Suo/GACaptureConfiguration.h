//
//  GACaptureConfiguration.h
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN




@interface GACaptureConfiguration : NSObject
    //Capture
@property(nonatomic,strong) AVCaptureMovieFileOutput *movieFileOutput;  //!<视频输出文件
@property(nonatomic,strong) AVCaptureSession *captureSession;           //!<捕获会话(链接输入输出)
@property(nonatomic,strong) AVCaptureDeviceInput *frontCameraInput;     //!<前输入
@property(nonatomic,strong) AVCaptureDeviceInput *backCameraInput;      //!<后输入
@property(nonatomic,strong) AVCaptureDeviceInput *audioInput;           //!<音频输入

@end

NS_ASSUME_NONNULL_END
