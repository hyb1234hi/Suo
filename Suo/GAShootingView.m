//
//  GAShootingView.m
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAShootingView.h"
#import <AVKit/AVKit.h>

@interface GAShootingView ()


@end

@implementation GAShootingView


+ (Class)layerClass{
    return AVCaptureVideoPreviewLayer.class;
}
-(AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer{
    return (AVCaptureVideoPreviewLayer*)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill]; //全屏填充
    }
    return self;
}





@end
