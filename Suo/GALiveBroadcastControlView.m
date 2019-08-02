//
//  GALiveBroadcastControlView.m
//  Suo
//
//  Created by ysw on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveBroadcastControlView.h"

@interface GALiveBroadcastControlView ()
@property(nonatomic,strong)UIButton *stopLiveBtn;   //!<退出直播
@property(nonatomic,strong)UIButton *sendMSGBtn;    //!<发送消息
@property(nonatomic,strong)UIButton *sendPrivateMSGBtn; //!<发送私信


@end

@implementation GALiveBroadcastControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    _stopLiveBtn = UIButton.new;
    [_stopLiveBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_stopLiveBtn setTitle:@"STOP" forState:UIControlStateNormal];
    
    [self addSubview:_stopLiveBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.stopLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 8, 16));
    }];
//    NSArray<UIView*> *views = @[_stopLiveBtn,];
//    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:16 tailSpacing:16];
//    [views mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(40);
//        make.bottom.mas_equalTo(self).inset(8);
//    }];
}

- (void)onButtonAction:(UIButton*)send{
    if (send == self.stopLiveBtn) {
        [self sendMSGToDelegateWithSel:@selector(stopLive)];
    }
}

//发送消息到代理
- (void)sendMSGToDelegateWithSel:(SEL)sel{
    if ([self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel];
    }
}

@end
