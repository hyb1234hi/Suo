//
//  GARecordControlView.m
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GARecordControlView.h"
#import "GARecordButton.h"

@interface GARecordControlView ()
    //右上角按钮
@property(nonatomic,strong)UIButton *conversionLensBtn; //!<反转镜头按钮
@property(nonatomic,strong)UIButton *beautyBtn;         //!<美颜按钮
@property(nonatomic,strong)UIButton *countdownBtn;      //!<倒计时按钮
@property(nonatomic,strong)UIButton *fsixedPointStopBtn;//!<定点停止按钮
@property(nonatomic,strong)UIButton *speedChangeBtn;       //!<变速按钮


@property(nonatomic,strong)GARecordButton *recordBtn;     //!<录制按钮
@property(nonatomic,strong)UIButton *propsBtn;      //!<道具
@property(nonatomic,strong)UIButton *musicBtn;      //!<音乐按钮


@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGFloat pregress;
@end

@implementation GARecordControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    
    UIButton*(^createButton)(NSString*,NSString*,LXMImagePosition) = ^(NSString*title,NSString*image,LXMImagePosition pos){
        UIButton *button = UIButton.new;
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button.titleLabel setFont:[MainFont fontWithSize:14]];
        
        [button setImagePosition:pos spacing:2];
        return button;
    };
    
    // right top button
     ({
         LXMImagePosition top = LXMImagePositionTop;
         _conversionLensBtn = createButton(@"反转镜头",@"iconHomeAllshareXitong",top);
         _beautyBtn = createButton(@"美颜",@"iconHomeAllshareXitong",top);
         _countdownBtn = createButton(@"倒计时",@"iconHomeAllshareXitong",top);
         _fsixedPointStopBtn = createButton(@"定点停",@"iconHomeAllshareXitong",top);
         _speedChangeBtn = createButton(@"变速",@"iconHomeAllshareXitong",top);
         
         NSArray<UIView*> *views = @[_conversionLensBtn,_beautyBtn,_countdownBtn,_fsixedPointStopBtn,_speedChangeBtn];
         
         for (UIView *view in views) {
         [self addSubview:view];
         }
         
         //action
         [_conversionLensBtn addTarget:self action:@selector(toggleSwitchLens:) forControlEvents:UIControlEventTouchUpInside];
         });
    
    
      //录制按钮 、道具、音乐
     ({
         _recordBtn = [[GARecordButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
         [_recordBtn addTarget:self action:@selector(recordButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
         
         _propsBtn = createButton(@"道具",@"",LXMImagePositionTop);
         _musicBtn = createButton(@"音乐",@"",LXMImagePositionTop);
         
         [self addSubview:_recordBtn];
         [self addSubview:_propsBtn];
         [self addSubview:_musicBtn];
         
     });
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //right layout
    ({
         NSArray<UIView*> *views = @[_conversionLensBtn,_beautyBtn,_countdownBtn,_fsixedPointStopBtn,_speedChangeBtn];
            //layout
        [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:16 leadSpacing:20 tailSpacing:200];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 70));
            make.right.mas_equalTo(-16);
        }];
    });
    
    // bottom layout
    ({
        [_recordBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self).inset(40);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [_propsBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.bottom.mas_equalTo(self.recordBtn);
            make.right.mas_equalTo(self.recordBtn.mas_left).inset(60);
            make.centerY.mas_equalTo(self.recordBtn);
        }];
        [_musicBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.recordBtn.mas_right).inset(60);
            make.centerY.mas_equalTo(self.recordBtn);
            //make.bottom.mas_equalTo(self.recordBtn);
        }];

    });
    
}

- (void)toggleSwitchLens:(UIButton*)send{
//    if ([self.delegate respondsToSelector:@selector(switchLens)]) {
//        [self.delegate switchLens];
//    }
}

- (void)recordButtonTapped:(GARecordButton*)send{
    switch (self.recordBtn.buttonState) {
            case GARecordButtonStateHidden:{
                [self stop];
            }break;
            case GARecordButtonIdel:{
                [self stop];
            }break;
            case GARecordButtonStateRecording:{
                [self record];
            }break;
    }
    
//    if ([self.delegate respondsToSelector:@selector(toggleRecord:)]) {
//        [self.delegate toggleRecord:send];
//    }
}


- (void)stop{
    [self.timer invalidate];
}
- (void)record{
    
    [_recordBtn setButtonState:GARecordButtonStateRecording];
    
    CGFloat max = 15;
    _pregress = 0;
    
    [_timer invalidate];
    
    __weak typeof(self) wself = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
        wself.pregress += 0.05 / max;
        [wself.recordBtn setProgress:wself.pregress];
        
        if (wself.pregress >= 1) {
            [wself.timer invalidate];
            [self stop];
        }
        
    }];
    
}


@end
