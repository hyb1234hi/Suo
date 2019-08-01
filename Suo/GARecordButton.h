//
//  GARecordButton.h
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GARecordButtonState) {
    GARecordButtonStateRecording,
    GARecordButtonStateHidden,
    GARecordButtonIdel
};

typedef NS_ENUM(NSUInteger, ResizingBehavior) {
    ResizingBehaviorAspectFit,
    ResizingBehaviorAspectFill,
    ResizingBehaviorStretch,
    ResizingBehaviorCenter
};

@interface GARecordButton : UIButton
@property(nonatomic,assign)GARecordButtonState buttonState;
@property(nonatomic,strong)UIColor *buttonColor;
@property(nonatomic,strong)UIColor *borderColor;
@property(nonatomic,strong)UIColor *progressColor;

@property(nonatomic,assign)CGFloat borderWidth;
@property(nonatomic,assign)BOOL closeWhenFinished;  //default no
@property(nonatomic,assign)BOOL playSounds;         //default yes


- (void)setProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
