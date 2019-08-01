//
//  GAShootingView.h
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AVCaptureVideoPreviewLayer;

NS_ASSUME_NONNULL_BEGIN

@interface GAShootingView : UIView
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer; //渲染层


@end

NS_ASSUME_NONNULL_END
