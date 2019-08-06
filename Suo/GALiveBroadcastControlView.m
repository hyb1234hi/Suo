//
//  GALiveBroadcastControlView.m
//  Suo
//
//  Created by ysw on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveBroadcastControlView.h"
#import "GACommentTextView.h"
#import "GAGoodsPushSelectView.h"

#import <BarrageRenderer.h>


@interface GALiveBroadcastControlView ()<BarrageRendererDelegate>
@property(nonatomic,strong)UIButton *stopLiveBtn;   //!<退出直播
@property(nonatomic,strong)UIButton *sendMSGBtn;    //!<发送消息
@property(nonatomic,strong)UIButton *sendPrivateMSGBtn; //!<发送私信

@property(nonatomic,strong)BarrageRenderer *renderer;   //!<弹幕渲染

// bottom
@property(nonatomic,strong)UIButton *sendMSG;
@property(nonatomic,strong)UIButton *pushGoods;
@property(nonatomic,strong)UIButton *pullMSG;

@end

@implementation GALiveBroadcastControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    _renderer = [[BarrageRenderer alloc] init];
    [_renderer setDelegate:self];
    [_renderer setSmoothness:0.8];
    [_renderer.view setUserInteractionEnabled:YES];
    [self addSubview:_renderer.view];
    [self sendSubviewToBack:_renderer.view];
    [_renderer start];
    
    _stopLiveBtn = UIButton.new;
    [_stopLiveBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_stopLiveBtn setTitle:@"STOP" forState:UIControlStateNormal];
    
    [self addSubview:_stopLiveBtn];
    
    //bottom
    ({
        _sendMSG = UIButton.new;
        _pushGoods = UIButton.new;
        _pullMSG = UIButton.new;
        
        [_sendMSG setTitle:@"send" forState:UIControlStateNormal];
        [_pushGoods setTitle:@"push" forState:UIControlStateNormal];
        [_pullMSG setTitle:@"消息" forState:UIControlStateNormal];
        
        [self addSubview:_sendMSG];
        [self addSubview:_pushGoods];
        [self addSubview:_pullMSG];
        
        [_sendMSG addTarget:self action:@selector(onSendMSG:) forControlEvents:UIControlEventTouchUpInside];
        [_pushGoods addTarget:self action:@selector(onPushGoods:) forControlEvents:UIControlEventTouchUpInside];
    });
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.stopLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 8, 16));
    }];
    
    [self.sendMSG mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 16, 16, 0));
    }];
    [self.pushGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sendMSG.mas_right).inset(16);
        make.bottom.mas_equalTo(self.sendMSG);
    }];
    [self.pullMSG mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pushGoods.mas_right).inset(16);
        make.bottom.mas_equalTo(self.pushGoods);
    }];
    
}

- (void)onPushGoods:(UIButton*)send{
    [GAGoodsPushSelectView.new show];
}
- (void)onSendMSG:(UIButton*)send{
    GACommentTextView *text = GACommentTextView.new;
    [text show];
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
