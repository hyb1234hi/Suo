//
//  GACaptureConfiguration.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACaptureConfiguration.h"

@implementation GACaptureConfiguration

- (instancetype)init{
    if (self = [super init]) {
        [self configurationSession];
    }
    return self;
}


#pragma mark - AVCapture Configuration
- (void)configurationSession{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        
            // 添加配置 input
        [self.captureSession beginConfiguration];
        
        if ([self.captureSession canAddInput:self.frontCameraInput]) {
            [self.captureSession addInput:self.frontCameraInput];
        }
        if ([self.captureSession canAddInput:self.audioInput]) {
            [self.captureSession addInput:self.audioInput];
        }
        
        if ( [self.captureSession canAddOutput:self.movieFileOutput]) {
            [self.captureSession addOutput:self.movieFileOutput];
            [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
            
            AVCaptureConnection* connection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
            if (connection.isVideoStabilizationSupported) {
                connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
            }
        }
        
        [self.captureSession commitConfiguration];
    //});
}

#pragma makr - getter
- (AVCaptureMovieFileOutput *)movieFileOutput{
    if (!_movieFileOutput) {
        _movieFileOutput = AVCaptureMovieFileOutput.new;
    }
    return _movieFileOutput;
}
- (AVCaptureSession *)captureSession{
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession startRunning];
    }
    return _captureSession;
}
- (AVCaptureDeviceInput *)frontCameraInput{
    if (!_frontCameraInput) {
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                                          mediaType:AVMediaTypeVideo
                                                                           position:AVCaptureDevicePositionFront];
        
        NSError *error = nil;
        _frontCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if (error) {
            NSLog(@"初始化前摄像头错误 %@",error.localizedDescription);
        }
    }
    return _frontCameraInput;
}
- (AVCaptureDeviceInput *)backCameraInput{
    if (!_backCameraInput) {
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                                          mediaType:AVMediaTypeVideo
                                                                           position:AVCaptureDevicePositionBack];
        NSError *error = nil;
        _backCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if (error) {
            NSLog(@"初始化前置相机出错： %@",error.localizedDescription);
        }
    }
    return _backCameraInput;
}
- (AVCaptureDeviceInput *)audioInput{
    if (!_audioInput) {
        AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        
        if (!audioDevice) {
            NSLog(@"初始化音频设备出错！");
        }
        
        NSError *error = nil;
        _audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
        if (error) {
            NSLog(@"初始化音频输入错误： %@",error.localizedDescription);
        }
    }
    return _audioInput;
}



@end
