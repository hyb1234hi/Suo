//
//  GARecordButton.m
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GARecordButton.h"
#import "UIColor+GAExtension.h"

#import <PRTween.h>
#import <AVKit/AVKit.h>
#import <CoreGraphics/CoreGraphics.h>


@interface GARecordButton ()
@property(nonatomic,weak)PRTweenOperation *tweenOperation;
@property(nonatomic,strong)AVAudioPlayer *startPlayer;
@property(nonatomic,strong)AVAudioPlayer *stopPlayer;

@property(nonatomic,strong)CALayer *circleBorder;
@property(nonatomic,strong)CAShapeLayer *progressLayer;
@property(nonatomic,strong)CAGradientLayer *gradientMaskLayer;

@property(nonatomic,assign)CGFloat currentProgress;
@property(nonatomic,assign)CGFloat isRecordingScale;

@end

@implementation GARecordButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _buttonColor = UIColor.redColor;
        _borderColor = UIColor.whiteColor;
        _borderWidth = 6.0;
        _progressColor = UIColor.redColor;
        _isRecordingScale = 1.0;
        _closeWhenFinished = NO;
        _buttonState = GARecordButtonIdel;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addTarget:self action:@selector(didTouchDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self drawButton];
    
    if (_playSounds && _startPlayer == nil) {
        NSURL *startURL = [[NSBundle bundleForClass:self.class] URLForResource:@"StartRecording" withExtension:@"aiff"];
        NSURL *stopURL = [[NSBundle bundleForClass:self.class] URLForResource:@"StartRecording" withExtension:@"aiff"];
        
        NSError *error = nil;
        _startPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:startURL error:&error];
        [_startPlayer prepareToPlay];
        if (error) {
            NSLog(@"初始化 启动声音播放器错误 ：%@",error.localizedDescription);
            error = nil;
        }
        
        _stopPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:stopURL error:&error];
        [_stopPlayer prepareToPlay];
        if (error) {
            NSLog(@"初始化 停止声音播放器错误 ：%@",error.localizedDescription);
        }
        
    }
}

- (void)drawButton{
    self.backgroundColor = UIColor.clearColor;
    CALayer *layer = self.layer;
    
    CGFloat startAngle = M_PI + M_PI_2;
    CGFloat endAngle = M_PI * 3 + M_PI_2;
    CGPoint centerPoint = self.center;
    
    _gradientMaskLayer = [self gradientMask];
    _progressLayer = CAShapeLayer.new;
    
    CGFloat radius = CGRectGetWidth(self.frame)/2.0 - self.borderWidth/2.0;
    _progressLayer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
    
    _progressLayer.backgroundColor = UIColor.clearColor.CGColor;
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor = UIColor.blackColor.CGColor;
    _progressLayer.lineWidth = self.borderWidth;
    _progressLayer.strokeStart = 0.0;
    _progressLayer.strokeEnd = 0.0;
    
    _gradientMaskLayer.mask = _progressLayer;
    [layer insertSublayer:_gradientMaskLayer atIndex:0];
    
    
    _circleBorder = CALayer.new;
    _circleBorder.backgroundColor = UIColor.clearColor.CGColor;
    _circleBorder.borderWidth = self.borderWidth;
    _circleBorder.borderColor = UIColor.whiteColor.CGColor;
    _circleBorder.bounds = self.bounds; //
    _circleBorder.anchorPoint = CGPointMake(0.5, 0.5);
    _circleBorder.position = self.center;
    _circleBorder.cornerRadius = CGRectGetWidth(self.frame)/2.0;
    [layer insertSublayer:_circleBorder atIndex:0];
}


- (void)drawRect:(CGRect)rect{
    CGRect buttonFrame = self.bounds;
    BOOL pressed = self.isHighlighted || self.isTracking;
    
    
    UIColor *recordButtonHighlightedColor = [_buttonColor withBrightness:0.3];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGRect resizedFrame = [self apply:ResizingBehaviorAspectFit rect:CGRectMake(0, 0, 100, 100) target:buttonFrame];
    
    CGContextTranslateCTM(context, CGRectGetMinX(resizedFrame), CGRectGetMinY(resizedFrame));
    CGContextScaleCTM(context, CGRectGetWidth(resizedFrame)/100, CGRectGetHeight(resizedFrame)/100);
 
    CGFloat radius = 10 + 37 * (MIN(_isRecordingScale*1.88, 1.0));
    CGFloat buttonScale = 1-(1-_isRecordingScale)*0.45;
    UIColor *buttonFillColor = pressed ? recordButtonHighlightedColor : _buttonColor;
    
    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 50, 50);
    CGContextScaleCTM(context, buttonScale, buttonScale);
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-39, -39, 78, 78) cornerRadius:radius];
    
    [buttonFillColor setFill];
    [rectanglePath fill];
    
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
}

- (void)layoutSubviews{
    
    _circleBorder.anchorPoint = CGPointMake(0.5, 0.5);
    _circleBorder.position = self.center;
    
    [super layoutSubviews];
}

- (CGRect)apply:(ResizingBehavior)behavior rect:(CGRect)rect target:(CGRect)target{
    if (CGRectEqualToRect(rect,target)  || CGRectEqualToRect(target, CGRectZero)) {
        return rect;
    }
    
    CGSize scales = CGSizeZero;
    scales.width = abs(target.size.width / rect.size.width);
    scales.height = abs(target.size.height / rect.size.height);
    
    switch (behavior) {
            
            case ResizingBehaviorAspectFit:{
                scales.width = scales.width < scales.height ? scales.width : scales.height;
                scales.height = scales.width;
            }break;
            
            case ResizingBehaviorAspectFill:{
                scales.width = scales.width > scales.height ? scales.width: scales.height;
                scales.height = scales.width;
            }break;
            
            case ResizingBehaviorStretch:{}break;
            
            case ResizingBehaviorCenter:{
                scales.width = 1;
                scales.height = 1;
            }break;
    }
    
    CGRect result = CGRectStandardize(rect);
    
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    
    result.origin.x = CGRectGetMinX(target) + (target.size.width - result.size.width) / 2.0;
    result.origin.y = CGRectGetMinY(target) + (target.size.height - result.size.height) / 2.0;
    return result;
}

- (CAGradientLayer*)gradientMask{
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = self.bounds;
    layer.locations = @[@(0),@(1)];
    
    
    layer.colors = @[(id)(_progressColor.CGColor),(id)(_progressColor.CGColor)];
    return layer;
}

- (void)didTouchDown{
    if (self.buttonState != GARecordButtonStateRecording) {
        self.buttonState = GARecordButtonStateRecording;
        if (_playSounds) {
            [_startPlayer play];
        }
    }else{
        if (_playSounds) {
            [_stopPlayer play];
        }
        
        if (_closeWhenFinished) {
            [self setProgress:1];
            [UIView animateWithDuration:0.3 animations:^{
                self.buttonState = GARecordButtonStateHidden;
                
            } completion:^(BOOL finished) {
                [self setProgress:0];
                self.currentProgress = 0;
            }];
        }else{
            self.buttonState = GARecordButtonIdel;
        }
    }
}

- (void)setRecording:(BOOL)recording{
    
    NSTimeInterval duration = 0.15;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @(recording ? 1.0 : 0.88);
    scale.toValue = @(recording ? 0.88 : 1.0);
    scale.duration = duration;
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.duration = duration;
    color.fillMode = kCAFillModeForwards;
    color.removedOnCompletion = NO;
    color.toValue = (id)(recording ? _progressColor.CGColor : _buttonColor.CGColor);
    
    
    CAAnimationGroup *circleAnimations = CAAnimationGroup.new;
    circleAnimations.removedOnCompletion = NO;
    circleAnimations.fillMode = kCAFillModeForwards;
    circleAnimations.duration = duration;
    circleAnimations.animations = @[scale,color];
    
    
    CABasicAnimation *borderColor =  [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColor.duration = duration;
    borderColor.fillMode = kCAFillModeForwards;
    borderColor.removedOnCompletion = NO;
    borderColor.toValue = (id)(recording ? _borderColor.CGColor : _buttonColor.CGColor);
    
    
    CABasicAnimation *borderScale = [CABasicAnimation animationWithKeyPath:@"opacity"];
    borderScale.fromValue = @(recording ? 1.0 : 0.0);
    borderScale.toValue = @(recording ? 0.0 : 1.0);
    borderScale.duration = duration;
    borderScale.fillMode = kCAFillModeForwards;
    borderScale.removedOnCompletion = NO;
    
    
    CAAnimationGroup *borderAnimations = CAAnimationGroup.new;
    borderAnimations.removedOnCompletion = NO;
    borderAnimations.fillMode = kCAFillModeForwards;
    borderAnimations.duration = duration;
    borderAnimations.animations =@[borderColor,borderScale];
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @(recording ? 0.0 : 1.0);
    fade.toValue = @(recording ? 1.0 : 0.0);
    fade.duration = duration;
    fade.fillMode = kCAFillModeForwards;
    fade.removedOnCompletion = NO;
    
    [_progressLayer addAnimation:fade forKey:@"fade"];
    
}
- (void)setProgress:(CGFloat)progress{
    _progressLayer.strokeEnd = progress;
}

// set
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void)setIsRecordingScale:(CGFloat)isRecordingScale{
    if (_isRecordingScale != isRecordingScale) {
        _isRecordingScale = isRecordingScale;
        [self setNeedsDisplay];
    }
}
- (void)setButtonColor:(UIColor *)buttonColor{
    if (_buttonColor != buttonColor) {
        _buttonColor = buttonColor;
        [self setNeedsDisplay];
    }
}
- (void)setBorderColor:(UIColor *)borderColor{
    if (_borderColor != borderColor) {
        _borderColor = borderColor;
        _circleBorder.borderColor = borderColor.CGColor;
        [self setNeedsDisplay];
    }
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self setNeedsDisplay];
    }
}
- (void)setProgressColor:(UIColor *)progressColor{
    if (_progressColor != progressColor) {
        _progressColor = progressColor;
        _gradientMaskLayer.colors = @[(id)progressColor.CGColor,(id)progressColor.CGColor];
    }
}

- (void)setButtonState:(GARecordButtonState)buttonState{
    if (_buttonState != buttonState) {
        _buttonState = buttonState;
        
        switch (buttonState) {
                case GARecordButtonIdel:{
                    self.alpha = 1.0;
                    _currentProgress = 0;
                    [self setProgress:0];
                    [self setRecording:NO];
                }break;
                
                case GARecordButtonStateHidden:{
                    self.alpha = 0;
                }break;
                
                case GARecordButtonStateRecording:{
                    self.alpha = 1.0;
                    [self setRecording:YES];
                }break;
        }
        
        //stop animation
        if (_tweenOperation) {
            [PRTween.sharedInstance removeTweenOperation:_tweenOperation];
        }
        
        // animate ont state to another
        CGFloat endValue = buttonState == GARecordButtonStateRecording ? 0 : 1.0;
        PRTweenPeriod *period = [PRTweenPeriod periodWithStartValue:_isRecordingScale endValue:endValue duration:0.15];
        
        
        _tweenOperation = [PRTween.sharedInstance addTweenPeriod:period updateBlock:^(PRTweenPeriod *period) {
            self->_isRecordingScale = period.tweenedValue;
        } completionBlock:nil];
        
    }
}
@end
